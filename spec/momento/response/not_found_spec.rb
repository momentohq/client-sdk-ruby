require 'momento/response'

RSpec.describe Momento::Response::NotFound do
  it_behaves_like 'response has status methods', true_statuses: [:not_found, :error] do
    let(:response) { build(:momento_response_not_found) }
  end
end
