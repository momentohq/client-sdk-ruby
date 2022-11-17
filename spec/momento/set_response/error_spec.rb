require 'momento/response'

RSpec.describe Momento::SetResponse::Error do
  let(:response) {
    build(:momento_set_response_error)
  }

  it_behaves_like Momento::SetResponse do
    let(:types) do
      { error?: true }
    end
  end
end
