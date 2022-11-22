require 'momento/response'

RSpec.describe Momento::DeleteCacheResponse::Success do
  let(:response) {
    build(:momento_delete_cache_response_success)
  }

  it_behaves_like Momento::DeleteCacheResponse do
    let(:subclass_attributes) do
      { success?: true }
    end
  end
end
