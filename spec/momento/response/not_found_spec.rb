require 'momento/response'

RSpec.describe Momento::Response::NotFound do
  it_behaves_like Momento::Response::Error do
    let(:response) { build(:momento_response_not_found) }
  end
end
