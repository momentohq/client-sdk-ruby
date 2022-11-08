require 'momento/response'

RSpec.shared_examples Momento::Response do
  it 'is a subclass' do
    expect(response).to be_a Momento::Response
  end
end
