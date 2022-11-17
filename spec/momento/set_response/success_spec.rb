require 'momento/response'

RSpec.describe Momento::SetResponse::Success do
  let(:response) {
    build(:momento_set_response_success)
  }

  it_behaves_like Momento::SetResponse do
    let(:types) do
      { success?: true }
    end
  end
end
