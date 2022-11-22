require 'momento/response'

RSpec.describe Momento::CreateCacheResponse::AlreadyExists do
  let(:response) {
    build(:momento_create_cache_response_already_exists)
  }

  it_behaves_like Momento::CreateCacheResponse do
    let(:subclass_attributes) do
      { already_exists?: true }
    end
  end
end
