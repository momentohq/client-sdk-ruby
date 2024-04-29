require 'momento'

RSpec.shared_examples Momento::DeleteResponse do
  it_behaves_like Momento::Response do
    let(:superclass_attributes) do
      {
        success?: false
      }
    end
  end

  it 'is a subclass' do
    expect(response).to be_a described_class
  end
end
