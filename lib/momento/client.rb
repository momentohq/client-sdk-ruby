# frozen_string_literal: true

require_relative "client/version"
require_relative 'simple_cache_client'

module Momento
  module Client
    class Error < StandardError; end
  end
end
