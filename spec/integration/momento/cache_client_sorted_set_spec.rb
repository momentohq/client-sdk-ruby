require 'momento'
require_relative '../spec_helper'

RSpec.describe Momento::CacheClient do
  let(:client) {
    ClientStateManager.cache_client
  }
  let(:cache_name) {
    ClientStateManager.cache_name
  }
  let(:sorted_set_name) {
    generate_random_string
  }
  let(:value) {
    generate_random_string
  }
  let(:score) {
    1.0
  }

  describe '#sorted_set_put_element' do
    subject {
      client.sorted_set_put_element(cache_name, sorted_set_name, value, score)
    }

    it_behaves_like 'it handles invalid caches'
    it_behaves_like 'it handles non-existent caches'

    context 'when writing a string' do
      it 'succeeds' do
        expect(subject).to be_success

        expect(client.sorted_set_fetch_by_score(cache_name, sorted_set_name))
          .to have_attributes(
                value_string_elements: [{ value: value, score: 1.0 }]
              )
      end

      it 'overwrites existing values' do
        expect(subject).to be_success

        expect(client.sorted_set_fetch_by_score(cache_name, sorted_set_name))
          .to have_attributes(
                value_string_elements: [{ value: value, score: 1.0 }]
              )

        expect(client.sorted_set_put_element(cache_name, sorted_set_name, value, 999.0)).to be_success

        expect(client.sorted_set_fetch_by_score(cache_name, sorted_set_name))
          .to have_attributes(
                value_string_elements: [{ value: value, score: 999.0 }]
              )
      end
    end

    context 'when writing binary data' do
      let(:value) {
        File.read("spec/support/assets/test.jpg", encoding: Encoding::ASCII_8BIT)
      }

      it 'succeeds' do
        expect(subject).to be_success

        expect(client.sorted_set_fetch_by_score(cache_name, sorted_set_name))
          .to have_attributes(
                value_bytes_elements: [{ value: value, score: 1.0 }]
              )
      end
    end

    context 'when writing an element with a short ttl' do
      it 'succeeds and the element times out before it can be read' do
        expect(client.sorted_set_put_element(cache_name, sorted_set_name, value, score,
          collection_ttl: Momento::CollectionTtl.of(1)
        )
              ).to be_success

        sleep(2)

        expect(client.sorted_set_fetch_by_score(cache_name, sorted_set_name))
          .to have_attributes(miss?: true)
      end
    end
  end

  describe '#sorted_set_put_elements' do
    subject {
      client.sorted_set_put_elements(cache_name, sorted_set_name, { value => score })
    }

    it_behaves_like 'it handles invalid caches'
    it_behaves_like 'it handles non-existent caches'

    context 'when writing String' do
      it 'succeeds' do
        expect(client.sorted_set_put_elements(cache_name, sorted_set_name, [[value, score], ['a', 0.0]])).to be_success

        expect(client.sorted_set_fetch_by_score(cache_name, sorted_set_name))
          .to have_attributes(
                value_string_elements: [{ value: 'a', score: 0.0 }, { value: value, score: 1.0 }]
              )
      end
    end

    context 'when writing binary data' do
      let(:value) {
        File.read("spec/support/assets/test.jpg", encoding: Encoding::ASCII_8BIT)
      }

      it 'succeeds' do
        expect(client.sorted_set_put_elements(cache_name, sorted_set_name, { value => score })).to be_success

        expect(client.sorted_set_fetch_by_score(cache_name, sorted_set_name))
          .to have_attributes(
                value_bytes_elements: [{ value: value, score: 1.0 }]
              )
      end
    end
  end

  describe '#sorted_set_fetch_by_score' do
    subject {
      client.sorted_set_fetch_by_score(cache_name, sorted_set_name)
    }

    it_behaves_like 'it handles invalid caches'
    it_behaves_like 'it handles non-existent caches'

    context 'when fetching a non-existent set' do
      it 'misses' do
        expect(client.sorted_set_fetch_by_score(cache_name, sorted_set_name)).to have_attributes(miss?: true)
      end
    end

    context 'when fetching string data' do
      before {
        client.sorted_set_put_elements(cache_name, sorted_set_name, {
          '1' => 0.0,
          '2' => 1.0,
          '3' => 0.5,
          '4' => 2.0,
          '5' => 1.5
        }
        )
      }

      it 'is able to fetch a full set ascending, with an end score larger than any in the set' do
        response = client.sorted_set_fetch_by_score(cache_name, sorted_set_name, min_score: 0.0, max_score: 9.9)
        expect(response).to have_attributes(hit?: true)

        values = response.value&.map { |hash| hash[:value] }
        expect(values).to eq(%w[1 3 2 5 4])
      end

      it 'is able to fetch part of the set descending, limited by the scores' do
        response = client.sorted_set_fetch_by_score(cache_name, sorted_set_name,
          sort_order: Momento::SortOrder::DESCENDING, min_score: 0.1, max_score: 1.9
        )
        expect(response).to have_attributes(hit?: true)

        values = response.value_string_elements&.map { |hash| hash[:value] }
        expect(values).to eq(%w[5 2 3])
      end

      it 'is able to fetch part of the set, limited by offset and count' do
        response = client.sorted_set_fetch_by_score(cache_name, sorted_set_name, offset: 1, count: 3)
        expect(response).to have_attributes(hit?: true)

        values = response.value_string_elements&.map { |hash| hash[:value] }
        expect(values).to eq(%w[3 2 5])
      end

      it 'returns a hit with no elements if the set exists, but the parameters do not match anything' do
        response = client.sorted_set_fetch_by_score(cache_name, sorted_set_name, offset: 9999)
        expect(response).to have_attributes(hit?: true)

        expect(response.value_string_elements).to be_empty
      end
    end
  end
end
