require 'momento/response'

RSpec.describe Momento::CreateCacheResponse::Success do
  let(:response) {
    build(:momento_create_cache_response_success)
  }

  it_behaves_like Momento::CreateCacheResponse do
    let(:subclass_attributes) do
      { success?: true }
    end
  end
end
