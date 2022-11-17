require 'momento/response'

RSpec.describe Momento::CreateCacheResponse::Error do
  let(:response) {
    build(:momento_create_cache_response_error)
  }

  it_behaves_like Momento::CreateCacheResponse do
    let(:types) do
      { error?: true }
    end
  end
end
