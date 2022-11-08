require 'momento/response'

RSpec.describe Momento::Response::InvalidArgument do
  it_behaves_like 'response has status methods', true_statuses: [:invalid_argument, :error] do
    let(:response) { build(:momento_response_invalid_argument) }
  end
end
