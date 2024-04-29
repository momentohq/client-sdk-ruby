require 'momento'

RSpec.shared_examples Momento::ResponseBuilder do
  describe '#from_block' do
    context 'when the exception is unexpected' do
      let(:exception) { StandardError.new("the front fell off") }

      it 'raises' do
        expect {
          builder.from_block { raise exception }
        }.to raise_error(exception)
      end
    end

    context 'when the response is unexpected' do
      it 'raises a TypeError' do
        expect {
          builder.from_block { Momento::Response.new }
        }.to raise_error(TypeError)
      end
    end
  end
end

RSpec.shared_examples '#from_block wraps gRPC exceptions' do
  it 'returns the approriate response' do
    expect(
      builder.from_block { raise exception }
    ).to be_a response_class
  end

  it 'wraps the exception' do
    expect(
      builder.from_block { raise exception }.error.cause
    ).to eq exception
  end

  it 'is a Momento::Response::Error' do
    expect(
      builder.from_block { raise exception }
    ).to be_a Momento::Response::Error
  end
end

RSpec.shared_examples '#from_block wraps gRPC exceptions as a response' do
  it 'returns the approriate response' do
    expect(
      builder.from_block { raise exception }
    ).to be_a response_class
  end
end

RSpec.shared_examples '#from_block wraps gRPC responses' do
  it 'returns the approriate response' do
    expect(
      builder.from_block { response }
    ).to be_a response_class
  end

  it 'is a Momento::Resposne' do
    expect(
      builder.from_block { response }
    ).to be_a Momento::Response
  end
end
