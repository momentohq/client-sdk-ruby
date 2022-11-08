require 'momento/response'

RSpec.describe Momento::Response::PermissionDenied do
  it_behaves_like Momento::Response::Error do
    let(:response) { build(:momento_response_permission_denied) }
  end
end
