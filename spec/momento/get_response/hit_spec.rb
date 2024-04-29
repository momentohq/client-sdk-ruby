require 'momento'

RSpec.describe Momento::GetResponse::Hit do
  let(:grpc_response) {
    build(:momento_cache_client_get_response, :hit)
  }
  let(:response) {
    build(:momento_get_response_hit, grpc_response: grpc_response)
  }

  it_behaves_like Momento::GetResponse do
    let(:subclass_attributes) do
      {
        hit?: true,
        value_string: grpc_response.cache_body,
        value_bytes: grpc_response.cache_body
      }
    end
  end

  describe '#value_bytes' do
    subject { response.value_bytes }

    it {
      is_expected.to have_attributes(
        frozen?: true,
        encoding: Encoding::ASCII_8BIT
      )
    }
  end

  describe '#value_string' do
    subject { response.value_string }

    it {
      is_expected.to have_attributes(
        frozen?: false,
        encoding: Encoding::UTF_8
      )
    }
  end

  describe '#to_s' do
    subject { response.to_s }

    let(:response) {
      build(:momento_get_response_hit, value: value)
    }

    context 'when the value is short' do
      let(:value) { "short" }

      it { is_expected.to match(/short/) }
    end

    context 'when the value is long' do
      let(:value) {
        v = <<-VALUE
        Lopado­temacho­selacho­galeo­kranio­leipsano­drim­hypo­trimmato­silphio­karabo­melito­katakechy­meno­kichl­epi­kossypho­phatto­perister­alektryon­opte­kephallio­kigklo­peleio­lagoio­siraio­baphe­tragano­pterygon
        VALUE

        # This is going directly to the GRPC response which requires ASCII 8Bit.
        v.force_encoding(Encoding::ASCII_8BIT)
      }

      it { is_expected.to include("...") }
    end
  end
end
