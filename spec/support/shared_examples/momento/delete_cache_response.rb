require 'momento/response'

RSpec.shared_examples Momento::DeleteCacheResponse do
  it 'is a subclass' do
    expect(response).to be_a described_class
  end

  describe 'type methods' do
    subject { response }

    let(:default_types) do
      {
        success?: false,
        error?: false
      }
    end

    it do
      is_expected.to have_attributes(
        default_types.merge(types)
      )
    end
  end
end
