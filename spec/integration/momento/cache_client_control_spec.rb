require 'momento'
require_relative '../spec_helper'

RSpec.describe Momento::CacheClient do
  let(:client) {
    ClientStateManager.cache_client
  }
  let(:cache_name) {
    ClientStateManager.cache_name
  }

  describe '#create_cache' do
    subject {
      client.create_cache(cache_name)
    }

    it_behaves_like 'it handles invalid caches'
  end

  describe '#delete_cache' do
    subject {
      client.delete_cache(cache_name)
    }

    it_behaves_like 'it handles invalid caches'
    it_behaves_like 'it handles non-existent caches'

    context 'when deleting a cache that exists' do
      let(:cache_name) {
        generate_random_string
      }

      before {
        client.create_cache(cache_name)
      }

      it 'succeeds' do
        expect(client.list_caches).to have_attributes(
          success?: true,
          cache_names: include(cache_name)
        )

        expect(client.delete_cache(cache_name)).to be_success

        response = client.list_caches
        expect(response).to have_attributes(success?: true)
        expect(response.cache_names).not_to include(cache_name)
      end
    end
  end

  describe '#list_caches' do
    subject {
      client.list_caches
    }

    context 'when listing caches' do
      it 'includes all caches' do
        expect(client.list_caches).to have_attributes(
          success?: true,
          cache_names: include(cache_name)
        )
      end
    end
  end
end
