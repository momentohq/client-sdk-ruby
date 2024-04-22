# rubocop:disable RSpec/DescribeClass
RSpec.describe 'Momento::Error subclasses' do
  # rubocop:enable RSpec/DescribeClass

  let(:cache_name) { "food and stuff" }
  let(:timeout) { 123 }
  # The contexts used by the types.
  let(:context) do
    {
      cache_name: cache_name,
      timeout: timeout
    }
  end
  let(:details) { "Basset hounds got long ears" }
  let(:exception) { StandardError.new("the front fell off") }
  let(:error) {
    described_class.new.tap do |e|
      e.cause = exception
      e.context = context
      e.details = details
    end
  }
  let(:superclass) { RuntimeError }

  shared_examples Momento::Error do
    subject { error }

    it { is_expected.to be_a(superclass) }

    it {
      is_expected.to have_attributes(
        error_code: error_code,
        message: match(message_re),
        to_s: match(message_re),
        cause: exception,
        context: context,
        details: details
      )
    }
  end

  describe Momento::Error::AlreadyExistsError do
    it_behaves_like Momento::Error do
      let(:error_code) { :ALREADY_EXISTS_ERROR }
      let(:message_re) { /Cache name: '#{cache_name}'/ }
    end
  end

  describe Momento::Error::AuthenticationError do
    it_behaves_like Momento::Error do
      let(:error_code) { :AUTHENTICATION_ERROR }
      let(:message_re) { /cache service: #{details}/ }
    end
  end

  describe Momento::Error::BadRequestError do
    it_behaves_like Momento::Error do
      let(:error_code) { :BAD_REQUEST_ERROR }
      let(:message_re) { /please contact Momento: #{details}/ }
    end
  end

  describe Momento::Error::CancelledError do
    it_behaves_like Momento::Error do
      let(:error_code) { :CANCELLED_ERROR }
      let(:message_re) { /please contact Momento: #{details}/ }
    end
  end

  describe Momento::Error::ClientResourceExhaustedError do
    it_behaves_like Momento::Error do
      let(:error_code) { :CLIENT_RESOURCE_EXHAUSTED }
      let(:message_re) { /A client resource \(most likely memory\) was exhausted./ }
    end
  end

  describe Momento::Error::ConnectionError do
    it_behaves_like Momento::Error do
      let(:error_code) { :CONNECTION_ERROR }
      let(:message_re) { /Error connecting to Momento servers/ }
    end
  end

  describe Momento::Error::FailedPreconditionError do
    it_behaves_like Momento::Error do
      let(:error_code) { :FAILED_PRECONDITION_ERROR }
      let(:message_re) { /System is not in a state required for the operation's execution/ }
    end
  end

  describe Momento::Error::InternalServerError do
    it_behaves_like Momento::Error do
      let(:error_code) { :INTERNAL_SERVER_ERROR }
      let(:message_re) { /please contact Momento: #{details}/ }
    end
  end

  describe Momento::Error::InvalidArgumentError do
    let(:superclass) { ArgumentError }

    it_behaves_like Momento::Error do
      let(:error_code) { :INVALID_ARGUMENT_ERROR }
      let(:message_re) { /Invalid argument passed to Momento client: #{details}/ }
    end
  end

  describe Momento::Error::LimitExceededError do
    it_behaves_like Momento::Error do
      let(:error_code) { :LIMIT_EXCEEDED_ERROR }
      let(:message_re) { /Request rate exceeded the limits for this account/ }
    end
  end

  describe Momento::Error::NotFoundError do
    it_behaves_like Momento::Error do
      let(:error_code) { :NOT_FOUND_ERROR }
      let(:message_re) { /Cache name: '#{cache_name}'/ }
    end
  end

  describe Momento::Error::PermissionError do
    it_behaves_like Momento::Error do
      let(:error_code) { :PERMISSION_ERROR }
      let(:message_re) { /operation on a cache: #{details}/ }
    end
  end

  describe Momento::Error::ServerUnavailableError do
    it_behaves_like Momento::Error do
      let(:error_code) { :SERVER_UNAVAILABLE }
      let(:message_re) { /The server was unable to handle the request/ }
    end
  end

  describe Momento::Error::TimeoutError do
    it_behaves_like Momento::Error do
      let(:error_code) { :TIMEOUT_ERROR }
      let(:message_re) { /The client's configured timeout was exceeded/ }
    end
  end

  describe Momento::Error::UnknownError do
    it_behaves_like Momento::Error do
      let(:error_code) { :UNKNOWN_ERROR }
      let(:message_re) { /CacheService failed due to an internal error/ }
    end
  end

  describe Momento::Error::UnknownServiceError do
    it_behaves_like Momento::Error do
      let(:error_code) { :UNKNOWN_SERVICE_ERROR }
      let(:message_re) { /please contact Momento: #{details}/ }
    end
  end
end
