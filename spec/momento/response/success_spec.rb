require 'momento/response'

RSpec.describe Momento::Response::Success do
  it_behaves_like Momento::Response do
    let(:response) { build(:momento_response_success) }
  end
end
