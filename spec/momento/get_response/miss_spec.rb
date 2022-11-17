require 'momento/response'

RSpec.describe Momento::GetResponse::Miss do
  let(:response) {
    build(:momento_get_response_miss)
  }

  it_behaves_like Momento::GetResponse do
    let(:types) do
      { miss?: true }
    end
  end
end
