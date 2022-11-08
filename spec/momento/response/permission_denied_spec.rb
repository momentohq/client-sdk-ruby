require 'momento/response'

RSpec.describe Momento::Response::PermissionDenied do
  it_behaves_like 'response has status methods', true_statuses: [:permission_denied, :error] do
    let(:response) { build(:momento_response_permission_denied) }
  end
end
