module Momento
  # Encapsulates gRPC configuration tunables
  class GrpcConfiguration
    # Number of seconds the client is willing to wait for an RPC to
    # complete before it is terminated with a DeadlineExceeded error
    attr_reader :deadline

    def self.with_deadline(deadline)
      return GrpcConfiguration.new(deadline)
    end

    def initialize(deadline)
      unless deadline.is_a? Integer
        raise Momento::Error::InvalidArgumentError,
          'Client timeout must be an integer'
      end
      if (deadline.is_a? Integer) && (deadline < 1)
        raise Momento::Error::InvalidArgumentError,
          'Client timeout must be positive'
      end

      @deadline = deadline
    end
  end
end
