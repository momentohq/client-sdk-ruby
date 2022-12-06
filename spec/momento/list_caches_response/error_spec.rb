require 'momento/response'

RSpec.describe Momento::ListCachesResponse::Error do
  let(:response) {
    build(:momento_list_caches_response_error)
  }

  it_behaves_like Momento::Response::Error

  it_behaves_like Momento::ListCachesResponse do
    let(:subclass_attributes) do
      {
        error?: true,
        error: be_a(Momento::Error)
      }
    end
  end
end
