require 'momento'
require_relative '../spec_helper'

RSpec.describe Momento::CacheClient do
  let(:client) {
    ClientStateManager.cache_client
  }
  let(:cache_name) {
    ClientStateManager.cache_name
  }
  let(:key) {
    generate_random_string
  }
  let(:value) {
    generate_random_string
  }

  describe '#get' do
    subject {
      client.get(cache_name, key)
    }

    it_behaves_like 'it handles invalid caches'
    it_behaves_like 'it handles non-existent caches'

    context 'when the key has no value on the server' do
      it 'returns a miss' do
        is_expected.to have_attributes(
          hit?: false,
          miss?: true,
          error?: false
        )
      end
    end

    context 'when the key has a value on the server' do
      before {
        client.set(cache_name, key, value)
      }

      it 'returns a hit' do
        is_expected.to have_attributes(
          hit?: true,
          miss?: false,
          error?: false,
          error: nil,
          value_string: value
        )
      end
    end
  end

  describe '#set' do
    subject {
      client.set(cache_name, key, value)
    }

    it_behaves_like 'it handles invalid caches'
    it_behaves_like 'it handles non-existent caches'

    context 'when writing a string' do
      it 'sets it' do
        expect(client.set(cache_name, key, value)).to be_success

        expect(client.get(cache_name, key))
          .to have_attributes(
            hit?: true,
            value_string: value
          )
      end
    end

    context 'when writing binary data' do
      let(:value) {
        File.read("spec/support/assets/test.jpg", encoding: Encoding::ASCII_8BIT)
      }

      it 'sets it' do
        expect(client.set(cache_name, key, value)).to be_success

        expect(client.get(cache_name, key))
          .to have_attributes(
            hit?: true,
            value_bytes: value
          )
      end
    end

    context 'when writing a value with a short ttl' do
      it 'succeeds and the value times out before it can be read' do
        expect(client.set(cache_name, key, value, ttl: 1)).to be_success

        sleep(2)

        expect(client.get(cache_name, key)).to have_attributes(miss?: true)
      end
    end
  end

  describe '#delete' do
    subject {
      client.delete(cache_name, key)
    }

    it_behaves_like 'it handles invalid caches'
    it_behaves_like 'it handles non-existent caches'

    context 'when deleting a value' do
      it 'deletes successfully' do
        client.set(cache_name, key, value)

        expect(client.delete(cache_name, key)).to have_attributes(success?: true)
        expect(client.get(cache_name, key)).to have_attributes(miss?: true)
      end

      it 'succeeds even if the value does not exist' do
        expect(client.delete(cache_name, key)).to have_attributes(success?: true)
        expect(client.get(cache_name, key)).to have_attributes(miss?: true)
      end
    end
  end
end
