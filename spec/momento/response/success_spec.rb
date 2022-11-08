require 'momento/response'

RSpec.describe Momento::Response::Success do
  it_behaves_like('response has status methods', true_statuses: [:success]) do
    let(:response) { build(:momento_response_success) }
  end
end
