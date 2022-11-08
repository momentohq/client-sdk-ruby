require 'momento/response'

RSpec.describe Momento::Response::AlreadyExists do
  it_behaves_like 'response has status methods', true_statuses: [:already_exists, :error] do
    let(:response) { build(:momento_response_already_exists) }
  end
end
