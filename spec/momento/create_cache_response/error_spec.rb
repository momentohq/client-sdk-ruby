require 'momento'

RSpec.describe Momento::CreateCacheResponse::Error do
  let(:response) {
    build(:momento_create_cache_response_error)
  }

  it_behaves_like Momento::Response::Error

  it_behaves_like Momento::CreateCacheResponse do
    let(:subclass_attributes) do
      {
        error?: true,
        error: be_a(Momento::Error)
      }
    end
  end
end
