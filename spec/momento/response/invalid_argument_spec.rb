require 'momento/response'

RSpec.describe Momento::Response::InvalidArgument do
  it_behaves_like Momento::Response::Error do
    let(:response) { build(:momento_response_invalid_argument) }
  end
end
