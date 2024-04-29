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

    private

    def initialize(api_key)
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
