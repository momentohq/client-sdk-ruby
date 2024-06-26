require 'momento'

RSpec.shared_examples Momento::GetResponse do
  it_behaves_like Momento::Response do
    let(:superclass_attributes) do
      {
        hit?: false,
        miss?: false,
        value_bytes: nil,
        value_string: nil
      }
    end
  end

  it 'is a subclass' do
    expect(response).to be_a described_class
  end
end
