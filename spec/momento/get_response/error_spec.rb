require 'momento/response'

RSpec.describe Momento::GetResponse::Error do
  let(:response) {
    build(:momento_get_response_error)
  }

  it_behaves_like Momento::GetResponse do
    let(:subclass_attributes) do
      { error?: true }
    end
  end
end
