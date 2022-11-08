require 'momento/response'

RSpec.describe Momento::Response::AlreadyExists do
  it_behaves_like Momento::Response::Error do
    let(:response) { build(:momento_response_already_exists) }
  end
end
