require 'momento/response'

RSpec.describe Momento::DeleteCacheResponse::Error do
  let(:response) {
    build(:momento_delete_cache_response_error)
  }

  it_behaves_like Momento::DeleteCacheResponse do
    let(:types) do
      { error?: true }
    end
  end
end
