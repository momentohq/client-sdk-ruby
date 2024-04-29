require 'momento'

RSpec.describe Momento::DeleteResponse::Error do
  let(:response) {
    build(:momento_delete_response_error)
  }

  it_behaves_like Momento::Response::Error

  it_behaves_like Momento::DeleteResponse do
    let(:subclass_attributes) do
      {
        error?: true,
        error: be_a(Momento::Error)
      }
    end
  end
end
