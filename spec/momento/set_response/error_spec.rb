require 'momento'

RSpec.describe Momento::SetResponse::Error do
  let(:response) {
    build(:momento_set_response_error)
  }

  it_behaves_like Momento::Response::Error

  it_behaves_like Momento::SetResponse do
    let(:subclass_attributes) do
      {
        error?: true,
        error: be_a(Momento::Error)
      }
    end
  end
end
