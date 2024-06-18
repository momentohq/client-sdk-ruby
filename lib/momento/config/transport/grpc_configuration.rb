module Momento
  # Encapsulates gRPC configuration tunables
  class GrpcConfiguration
    # Number of milliseconds the client is willing to wait for an RPC to
    # complete before it is terminated with a DeadlineExceeded error
    attr_reader :deadline

    # Number of gRPC channels to create. Each channel can multiplex up to
    # 100 concurrent requests. The default is 1, and this should not be
    # overridden unless you are making a high volume of requests.
    attr_reader :num_grpc_channels

    def with_deadline(deadline)
      return GrpcConfiguration.new(deadline, @num_grpc_channels)
    end

    def with_num_grpc_channels(num_grpc_channels)
      return GrpcConfiguration.new(@deadline, num_grpc_channels)
    end

    def initialize(deadline, num_grpc_channels = 1)
      unless deadline.is_a? Integer
        raise Momento::Error::InvalidArgumentError,
          'Client timeout must be an integer'
      end
      if (deadline.is_a? Integer) && (deadline < 1)
        raise Momento::Error::InvalidArgumentError,
          'Client timeout must be positive'
      end

      @deadline = deadline
      @num_grpc_channels = num_grpc_channels
    end
  end
end
