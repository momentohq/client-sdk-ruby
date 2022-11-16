require 'momento/response'

RSpec.describe Momento::DeleteResponse::Error do
  let(:response) {
    build(:momento_delete_response_error)
  }

  it_behaves_like Momento::DeleteResponse do
    let(:types) do
      { error?: true }
    end
  end
end
