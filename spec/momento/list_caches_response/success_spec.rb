require 'momento'

RSpec.describe Momento::ListCachesResponse::Success do
  let(:cache_names) { ["foo", "bar", "baz"] }
  let(:grpc_list_caches_response) {
    build(
      :momento_control_client_list_caches_response,
      cache_names: cache_names
    )
  }
  let(:response) {
    described_class.new(grpc_response: grpc_list_caches_response)
  }

  it_behaves_like Momento::ListCachesResponse do
    let(:subclass_attributes) do
      {
        success?: true,
        cache_names: cache_names
      }
    end
  end

  describe '#to_s' do
    subject { response.to_s }

    let(:displayed_names) {
      cache_names.first(
        described_class.const_get(:CACHE_NAMES_TO_DISPLAY)
      )
    }

    context 'when there are few caches' do
      let(:cache_names) { ["foo", "bar"] }

      it { is_expected.to include cache_names.join(", ") }
    end

    context 'when there are many caches' do
      let(:cache_names) {
        [
          "secrets", "top secret", "double top secret",
          "a garden shed at the country club",
          "dragon hoard", "under the mattress",
          "on the Moon", "on the secret Moon"
        ]
      }

      it {
        is_expected.to include(", ...").and include(*displayed_names)
      }
    end
  end
end
