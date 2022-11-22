require 'momento/response'

RSpec.shared_examples Momento::Response do
  let(:response_attributes) do
    {
      error?: false
    }
  end

  describe 'attributes' do
    it 'has the expected attributes' do
      expected_attributes = response_attributes
        .merge(superclass_attributes)

      begin
        # rubocop:disable Style/RedundantSelf
        expected_attributes.merge!(self.subclass_attributes)
        # rubocop:enable Style/RedundantSelf
      rescue NoMethodError
        # subclass_attributes might not be defined.
      end

      expect(response).to have_attributes(**expected_attributes)
    end
  end
end
