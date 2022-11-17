require 'momento/response'

RSpec.describe Momento::DeleteCacheResponse::Success do
  let(:response) {
    build(:momento_delete_cache_response_success)
  }

  it_behaves_like Momento::DeleteCacheResponse do
    let(:types) do
      { success?: true }
    end
  end
end
