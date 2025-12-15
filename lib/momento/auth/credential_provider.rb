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
    # @deprecated Please use {#from_env_var_v2} instead.
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
    # @deprecated Please use {#from_api_key_v2} or {#from_disposable_token} instead.
    def self.from_string(api_key)
      raise Momento::Error::InvalidArgumentError, 'Auth token string cannot be empty' if api_key.empty?

      new(api_key)
    end

    # Creates a CredentialProvider from a Momento disposable token
    # @param token [String] the Momento disposable token
    # @return [Momento::CredentialProvider]
    # @raise [Momento::Error::InvalidArgumentError] if the token is invalid
    def self.from_disposable_token(token)
      raise Momento::Error::InvalidArgumentError, 'Auth token string cannot be empty' if token.empty?

      new(token)
    end

    # Creates a CredentialProvider from a v2 API key string and endpoint.
    # @param api_key [String] the v2 API key
    # @param endpoint [String] the Momento service endpoint
    # @return [Momento::CredentialProvider]
    # @raise [Momento::Error::InvalidArgumentError] if parameters are invalid
    def self.from_api_key_v2(api_key:, endpoint:)
      raise Momento::Error::InvalidArgumentError, 'API key cannot be empty' if api_key.nil? || api_key.empty?
      raise Momento::Error::InvalidArgumentError, 'Endpoint cannot be empty' if endpoint.nil? || endpoint.empty?

      unless v2_api_key?(api_key)
        raise Momento::Error::InvalidArgumentError,
          'Received an invalid v2 API key. Are you using the correct key? \
          Or did you mean to use `from_string()` with a legacy key instead?'
      end

      allocate.tap do |instance|
        instance.send(:initialize_from_v2, api_key, endpoint)
      end
    end

    # Creates a CredentialProvider from a v2 API key and endpoint loaded from environment variables
    # MOMENTO_API_KEY and MOMENTO_ENDPOINT by default.
    # @param api_key_env_var [String] optionally provide alternate environment variable containing the v2 API key
    # @param endpoint_env_var [String] optionally provide alternate environment variable containing the endpoint
    # @return [Momento::CredentialProvider]
    # @raise [Momento::Error::InvalidArgumentError] if parameters are invalid
    def self.from_env_var_v2(api_key_env_var: "MOMENTO_API_KEY", endpoint_env_var: "MOMENTO_ENDPOINT")
      api_key = ENV.fetch(api_key_env_var) {
        raise Momento::Error::InvalidArgumentError, "Env var #{api_key_env_var} must be set"
      }
      endpoint = ENV.fetch(endpoint_env_var) {
        raise Momento::Error::InvalidArgumentError, "Env var #{endpoint_env_var} must be set"
      }
      unless v2_api_key?(api_key)
        raise Momento::Error::InvalidArgumentError,
          'Received an invalid v2 API key. Are you using the correct key? \
          Or did you mean to use `from_env_var()` with a legacy key instead?'
      end
      allocate.tap do |instance|
        instance.send(:initialize_from_v2, api_key, endpoint)
      end
    end

    private

    def initialize_from_v2(api_key, endpoint)
      raise Momento::Error::InvalidArgumentError, 'API key cannot be empty' if api_key.nil? || api_key.empty?
      raise Momento::Error::InvalidArgumentError, 'Endpoint cannot be empty' if endpoint.nil? || endpoint.empty?

      @api_key = api_key
      @control_endpoint = "control.#{endpoint}"
      @cache_endpoint = "cache.#{endpoint}"
    end

    def initialize(api_key)
      if v2_api_key?(api_key)
        raise Momento::Error::InvalidArgumentError,
          'Received a v2 API key. Are you using the correct key? Or did you mean to use\
           `from_api_key_v2()` or `from_env_var_v2()` instead?'
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

def v2_api_key?(api_key)
  false if base64?(api_key)

  key_parts = api_key.split('.')
  raise Momento::Error::InvalidArgumentError, 'Malformed legacy API key' if key_parts.size != 3

  decoded_key = Base64.decode64(key_parts[1])
  key_json = JSON.parse(decoded_key, symbolize_names: true)
  key_json[:t] == 'g'
rescue ArgumentError, JSON::ParserError
  false
end
