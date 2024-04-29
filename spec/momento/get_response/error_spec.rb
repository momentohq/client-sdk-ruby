require 'momento'

RSpec.describe Momento::GetResponse::Error do
  let(:response) {
    build(:momento_get_response_error)
  }

  it_behaves_like Momento::Response::Error

  it_behaves_like Momento::GetResponse do
    let(:subclass_attributes) do
      {
        error?: true,
        error: be_a(Momento::Error)
      }
    end
  end
end
