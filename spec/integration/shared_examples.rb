# Contains shared test cases that can be reused across functions under test.
module SharedExamples
  RSpec.shared_context 'when the cache does not exist', :include_non_existent_cache do
    let(:cache_name) { "this cache does not exist" }
  end

  RSpec.shared_context 'when the cache name is invalid', :include_invalid_cache_name do
    let(:cache_name) { "\xFF" }
  end

  RSpec.shared_examples 'it handles invalid caches' do
    it "responds with InvalidArgumentError", :include_invalid_cache_name do
      is_expected.to have_attributes(
        error?: true,
        error: have_attributes(
          error_code: :INVALID_ARGUMENT_ERROR
        )
      )
    end
  end

  RSpec.shared_examples 'it handles non-existent caches' do
    it "responds with NotFoundError", :include_non_existent_cache do
      is_expected.to have_attributes(
        error?: true,
        error: have_attributes(
          error_code: :NOT_FOUND_ERROR
        )
      )
    end
  end
end
