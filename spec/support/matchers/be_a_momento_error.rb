RSpec::Matchers.define :be_a_momento_error do
  match(notify_expectation_failures: true) do |actual|
    @context ||= {}

    expect(actual).to be_a(Momento::Error)

    details = if @grpc_exception
                @grpc_exception.details
              elsif @exception
                @exception.message
              end

    expect(actual).to have_attributes(
      exception: @exception,
      context: @context,
      details: details
    )

    if @grpc_exception
      expect(actual.transport_details).to have_attributes(
        grpc: have_attributes(
          code: @grpc_exception.code,
          details: @grpc_exception.details,
          metadata: @grpc_exception.metadata
        )
      )
    end

    true
  end

  chain :with_context do |context|
    @context = context
  end

  chain :with_grpc_exception do |exception|
    @exception = exception
    @grpc_exception = exception
  end

  chain :with_exception do |exception|
    @exception = exception
  end
end
