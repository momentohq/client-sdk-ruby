RSpec.shared_examples 'it wraps GRPC exceptions' do
  it 'returns the approriate response' do
    expect(
      described_class.build_response(grpc_exception)
    ).to be_a response_class
  end

  it 'wraps the exception' do
    expect(
      described_class.build_response(grpc_exception).grpc_exception
    ).to eq grpc_exception
  end
end
