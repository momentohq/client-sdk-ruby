require_relative 'error/types'

module Momento
  # Errors from the Momento client or service.
  module Error
    attr_accessor :cause, :context, :transport_details, :details

    def to_s
      message
    end
  end
end
