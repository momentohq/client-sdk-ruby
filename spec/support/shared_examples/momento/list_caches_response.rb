require 'momento/response'

RSpec.shared_examples Momento::ListCachesResponse do
  it_behaves_like Momento::Response do
    let(:superclass_attributes) do
      {
        success?: false,
        cache_names: nil,
        next_token: nil
      }
    end
  end

  it 'is a subclass' do
    expect(response).to be_a described_class
  end
end
