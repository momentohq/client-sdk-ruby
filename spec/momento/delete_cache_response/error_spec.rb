require 'momento'

RSpec.describe Momento::DeleteCacheResponse::Error do
  let(:response) {
    build(:momento_delete_cache_response_error)
  }

  it_behaves_like Momento::Response::Error

  it_behaves_like Momento::DeleteCacheResponse do
    let(:subclass_attributes) do
      {
        error?: true,
        error: be_a(Momento::Error)
      }
    end
  end
end
