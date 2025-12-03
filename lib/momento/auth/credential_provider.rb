require "base64"
require "json"

module Momento
  # Contains the information required for a Momento client to connect to and authenticate with Momento services.
  class CredentialProvider
    attr_reader :api_key, :control_endpoint, :cache_endpoint

    # Creates a CredentialProvider from a Momento API key loaded from an environment variable.
    # @param env_var_name [String] the environment variable containing the API key
    # @return [Momento::CredentialProvider]
    # @raise [Momento::Error::InvalidArgumentError] if the API key is invalid
    def self.from_env_var(env_var_name)
      api_key = ENV.fetch(env_var_name) {
        raise Momento::Error::InvalidArgumentError, "Env var #{env_var_name} must be set"
      }
      new(api_key)
    end

    # Creates a CredentialProvider from a Momento API key
    # @param api_key [String] the Momento API key
    # @return [Momento::CredentialProvider]
    # @raise [Momento::Error::InvalidArgumentError] if the API key is invalid
    def self.from_string(api_key)
      raise Momento::Error::InvalidArgumentError, 'Auth token string cannot be empty' if api_key.empty?

      new(api_key)
    end

    # Creates a CredentialProvider from a global API key string and endpoint.
    # Global API keys do not require parsing - they can be used directly.
    # @param api_key [String] the global API key
    # @param endpoint [String] the endpoint (e.g., "cell-us-east-1-1.prod.a.momentohq.com")
    # @return [Momento::CredentialProvider]
    # @raise [Momento::Error::InvalidArgumentError] if parameters are invalid
    def self.global_key_from_string(api_key:, endpoint:)
      raise Momento::Error::InvalidArgumentError, 'API key cannot be empty' if api_key.nil? || api_key.empty?
      raise Momento::Error::InvalidArgumentError, 'Endpoint cannot be empty' if endpoint.nil? || endpoint.empty?

      unless global_api_key?(api_key)
        raise Momento::Error::InvalidArgumentError,
          'Provided API key is not a valid global API key. Are you using the correct key? \
          Or did you mean to use `from_string()` instead?'
      end

      allocate.tap do |instance|
        instance.send(:initialize_from_global, api_key, endpoint)
      end
    end

    # Creates a CredentialProvider from a global API key loaded from an environment variable.
    # Global API keys do not require parsing - they can be used directly.
    # @param env_var_name [String] the environment variable containing the global API key
    # @param endpoint [String] the endpoint (e.g., "cell-us-east-1-1.prod.a.momentohq.com")
    # @return [Momento::CredentialProvider]
    # @raise [Momento::Error::InvalidArgumentError] if parameters are invalid
    def self.global_key_from_env_var(env_var_name, endpoint:)
      api_key = ENV.fetch(env_var_name) {
        raise Momento::Error::InvalidArgumentError, "Env var #{env_var_name} must be set"
      }
      raise Momento::Error::InvalidArgumentError, 'Endpoint cannot be empty' if endpoint.nil? || endpoint.empty?

      unless global_api_key?(api_key)
        raise Momento::Error::InvalidArgumentError,
          'Provided API key is not a valid global API key. Are you using the correct key? \
          Or did you mean to use `from_env_var()` instead?'
      end
      allocate.tap do |instance|
        instance.send(:initialize_from_global, api_key, endpoint)
      end
    end

    private

    def initialize_from_global(api_key, endpoint)
      @api_key = api_key
      @control_endpoint = "control.#{endpoint}"
      @cache_endpoint = "cache.#{endpoint}"
    end

    def initialize(api_key)
      if global_api_key?(api_key)
        raise Momento::Error::InvalidArgumentError,
          'Received a global API key. Are you using the correct key? Or did you mean to use\
           `global_key_from_string()` or `global_key_from_environment_variable()` instead?'
      end

      decoded_token = decode_api_key(api_key)
      @api_key = decoded_token.api_key
      @control_endpoint = decoded_token.control_endpoint
      @cache_endpoint = decoded_token.cache_endpoint
    rescue StandardError => e
      raise Momento::Error::InvalidArgumentError, e.message
    end

    AuthTokenData = Struct.new(:api_key, :cache_endpoint, :control_endpoint)

    def decode_api_key(api_key)
      decode_v1_key(api_key)
    rescue StandardError
      decode_legacy_key(api_key)
    end

    def decode_legacy_key(api_key)
      key_parts = api_key.split('.')
      raise Momento::Error::InvalidArgumentError, 'Malformed legacy API key' if key_parts.size != 3

      decoded_key = Base64.decode64(key_parts[1])
      key_json = JSON.parse(decoded_key, symbolize_names: true)
      validate_key_json(key_json, %i[c cp])

      AuthTokenData.new(api_key, key_json[:c], key_json[:cp])
    end

    def decode_v1_key(api_key)
      decoded_key = Base64.decode64(api_key)
      key_json = JSON.parse(decoded_key, symbolize_names: true)
      validate_key_json(key_json, %i[api_key endpoint])

      AuthTokenData.new(key_json[:api_key], "cache.#{key_json[:endpoint]}", "control.#{key_json[:endpoint]}")
    rescue StandardError
      raise Momento::Error::InvalidArgumentError, 'Malformed Momento API Key'
    end

    def validate_key_json(key_json, required_fields)
      missing_fields = required_fields.reject { |field| key_json.key?(field) }
      return if missing_fields.empty?

      raise Momento::Error::InvalidArgumentError,
        "Required fields are missing: #{missing_fields.join(', ')}"
    end
  end
end

def base64?(string)
  return false if string.nil? || string.empty?

  Base64.strict_decode64(string)
  true
rescue ArgumentError
  false
end

def global_api_key?(api_key)
  if base64?(api_key)
    raise Momento::Error::InvalidArgumentError,
      'Did not expect global API key to be base64 encoded. Are you using the correct key?'
  end

  key_parts = api_key.split('.')
  raise Momento::Error::InvalidArgumentError, 'Malformed legacy API key' if key_parts.size != 3

  decoded_key = Base64.decode64(key_parts[1])
  key_json = JSON.parse(decoded_key, symbolize_names: true)
  key_json[:t] == 'g'
rescue ArgumentError, JSON::ParserError
  false
end
