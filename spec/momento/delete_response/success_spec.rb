require 'momento/response'

RSpec.describe Momento::DeleteResponse::Success do
  let(:response) {
    build(:momento_delete_response_success)
  }

  it_behaves_like Momento::DeleteResponse do
    let(:types) do
      { success?: true }
    end
  end
end
