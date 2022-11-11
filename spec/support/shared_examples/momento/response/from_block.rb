require 'momento/response'

RSpec.shared_examples 'it wraps gRPC exceptions' do
  it 'returns the approriate response' do
    expect(
      described_class.from_block { raise exception }
    ).to be_a response_class
  end

  it 'wraps the exception' do
    expect(
      described_class.from_block { raise exception }.grpc_exception
    ).to eq exception
  end
end

RSpec.shared_examples 'it wraps gRPC responses' do
  it 'returns the approriate response' do
    expect(
      described_class.from_block { response }
    ).to be_a response_class
  end
end

RSpec.shared_examples '.from_block' do
  describe '.from_block' do
    context 'when the exception is unexpected' do
      let(:exception) { StandardError.new("the front fell off") }

      it 'raises' do
        expect {
          described_class.from_block { raise exception }
        }.to raise_error(exception)
      end
    end

    context 'when the response is unexpected' do
      it 'raises a TypeError' do
        expect {
          described_class.from_block { Momento::Response.new }
        }.to raise_error(TypeError)
      end
    end
  end
end
