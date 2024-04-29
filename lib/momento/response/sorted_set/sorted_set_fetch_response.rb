require 'grpc'
require_relative '../error'
require_relative '../../generated/cacheclient_pb'

module Momento
  # A response containing the elements retrieved from a sorted set.
  class SortedSetFetchResponse < Response
    # The sorted set exists and any matching elements were fetched.
    # @return [Boolean]
    def hit?
      false
    end

    # The sorted set does not exist.
    # @return [Boolean]
    def miss?
      false
    end

    # The fetched values as UTF-8 Strings and their scores.
    # @return [(Array[{ value: String, score: Float }] | nil)] the UTF-8 elements and their scores
    def value_string_elements
      nil
    end

    alias value value_string_elements

    # The fetched values as ASCII_8BIT Strings and their scores.
    # @return [(Array[{ value: String, score: Float }] | nil)] the ASCII_8BIT elements and their scores
    def value_bytes_elements
      nil
    end

    # @!method to_s
    #   Displays the response and the value, if any.
    #   A long value will be truncated.
    #   @return [String]

    # @private
    class Hit < SortedSetFetchResponse
      # rubocop:disable Lint/MissingSuper
      def initialize(grpc_response:)
        @grpc_response = grpc_response
      end
      # rubocop:enable Lint/MissingSuper

      def hit?
        true
      end

      def value_string_elements
        @grpc_response.elements.map do |element|
          { value: element.value.dup.force_encoding('UTF-8'), score: element.score }
        end
      end

      alias value value_string_elements

      def value_bytes_elements
        @grpc_response.elements.map do |element|
          { value: element.value, score: element.score }
        end
      end

      def to_s
        "#{super}: #{display_string(value_string)}"
      end
    end

    # @private
    class Miss < SortedSetFetchResponse
      def miss?
        true
      end
    end

    # @private
    class Error < SortedSetFetchResponse
      include Momento::Response::Error
    end
  end

  # @private
  class SortedSetFetchResponseBuilder < ResponseBuilder
    # Build a Momento::SortedSetFetchResponse from a block of code
    # which returns a MomentoProtos::CacheClient::PB__SortedSetFetchResponse.
    #
    # @return [Momento::SortedSetFetchResponse]
    # @raise [StandardError] when the exception is not recognized.
    # @raise [TypeError] when the response is not recognized.
    def from_block
      response = yield
    rescue *RESCUED_EXCEPTIONS => e
      SortedSetFetchResponse::Error.new(exception: e, context: context)
    else
      raise TypeError unless response.is_a?(MomentoProtos::CacheClient::PB__SortedSetFetchResponse)

      case response.sorted_set
      when :found
        SortedSetFetchResponse::Hit.new(grpc_response: response.found.values_with_scores)
      when :missing
        SortedSetFetchResponse::Miss.new
      else
        raise "Unknown sorted set fetch result: #{response.sorted_set}"
      end
    end
  end
end
