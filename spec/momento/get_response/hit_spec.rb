require 'momento/response'

RSpec.describe Momento::GetResponse::Hit do
  let(:grpc_response) {
    build(:momento_cache_client_get_response, :hit)
  }
  let(:response) {
    build(:momento_get_response_hit, grpc_response: grpc_response)
  }

  it_behaves_like Momento::GetResponse do
    let(:subclass_attributes) do
      {
        hit?: true,
        value: grpc_response.cache_body,
        to_s: response.value
      }
    end
  end
end
