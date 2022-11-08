require 'momento/response'

RSpec.shared_examples Momento::Response::Error do
  it_behaves_like Momento::Response

  it 'is a subclass' do
    expect(response).to be_a Momento::Response::Error
  end
end
