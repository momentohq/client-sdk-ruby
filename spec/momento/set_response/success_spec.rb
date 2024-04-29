require 'momento'

RSpec.describe Momento::SetResponse::Success do
  let(:response) {
    build(:momento_set_response_success)
  }

  it_behaves_like Momento::SetResponse do
    let(:subclass_attributes) do
      {
        success?: true
      }
    end
  end

  describe '#to_s' do
    subject { response.to_s }

    let(:response) {
      build(:momento_set_response_success, key: key, value: value)
    }

    context 'when the key and value are short' do
      let(:key) { "foo" }
      let(:value) { "bar" }

      it {
        is_expected.to include(response.key).and include(response.value)
      }
    end

    context 'when the key and value are long' do
      let(:key) {
        "This one time I ate so many Cheetos that my fingers turned orange for, like, a week."
      }
      let(:value) {
        <<-VALUE
        This is the string that never ends. It just goes on and on my friends. Somebody started typing without knowing what it was.
        VALUE
      }

      it {
        is_expected.to include(response.key[0, 10])
          .and include(response.value[0, 10])
          .and include("...")
      }
    end
  end
end
