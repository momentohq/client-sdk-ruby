require "momento/auth/credential_provider"

CONTROL_ENDPOINT_LEGACY = "control.example.com".freeze
CACHE_ENDPOINT_LEGACY = "cache.example.com".freeze
CONTROL_ENDPOINT_V1 = "control.test.momentohq.com".freeze
CACHE_ENDPOINT_V1 = "cache.test.momentohq.com".freeze

# *** These API keys are fake and nonfunctional ***

LEGACY_API_KEY_VALID = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJzcXVpcnJlbCIsImNwIjoiY29udHJvbC5leGFtcGxlLmNvbSIsImMiOiJjYWNoZS\
5leGFtcGxlLmNvbSJ9.YY7RSMBCpMRs_qgbNkW0PYC2eX-MukLixLWJyvBpnMVaOba-OV0G5jgNmNbtn4zaLT8tlEncV6wQ_CkTI_PvoA".freeze
V1_API_KEY_VALID = "eyJhcGlfa2V5IjogImV5SjBlWEFpT2lKS1YxUWlMQ0poYkdjaU9pSklVekkxTmlKOS5leUpwYzNNaU9pSlBibXhwYm1VZ1NsZFV\
JRUoxYVd4a1pYSWlMQ0pwWVhRaU9qRTJOemd6TURVNE1USXNJbVY0Y0NJNk5EZzJOVFV4TlRReE1pd2lZWFZrSWpvaUlpd2ljM1ZpSWpvaWFuSnZZMnRsZE\
VCbGVHRnRjR3hsTG1OdmJTSjkuOEl5OHE4NExzci1EM1lDb19IUDRkLXhqSGRUOFVDSXV2QVljeGhGTXl6OCIsICJlbmRwb2ludCI6ICJ0ZXN0Lm1vbWVud\
G9ocS5jb20ifQ==".freeze
V1_INNER_KEY = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJPbmxpbmUgSldUIEJ1aWxkZXIiLCJpYXQiOjE2NzgzMDU4MTIsImV4cC\
I6NDg2NTUxNTQxMiwiYXVkIjoiIiwic3ViIjoianJvY2tldEBleGFtcGxlLmNvbSJ9.8Iy8q84Lsr-D3YCo_HP4d-xjHdT8UCIuvAYcxhFMyz8".freeze

LEGACY_API_KEY_MISSING_CONTROL_ENDPOINT = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJzcXVpcnJlbCIsImMiOiJjYWNoZS5leGFtcGxlLmNvbSJ\
9.RzLpBXut4s0fEXHtVIYVNb6Z8tiHSP9iu2j6OJpJHDksNXuOgTVFlMyG4V3gvMLMUwQmgtov-U9pMbaghQnr-Q".freeze
LEGACY_API_KEY_MISSING_CACHE_ENDPOINT = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJzcXVpcnJlbCIsImNwIjoiY29udHJvbC5leGFtcGxlLmNvb\
SJ9.obg5-runV-bdp0ZTV_2DGDFdRfc6aIRHaSBGbK3QaACPXwF6e8ghBYg2LDXXOWgbdpy6wEfDVIPgYZ0yXxVqvg".freeze
V1_API_KEY_MISSING_KEY = "eyJlbmRwb2ludCI6ICJhLmIuY29tIn0=".freeze
V1_API_KEY_MISSING_ENDPOINT = "eyJhcGlfa2V5IjogImV5SmxibVJ3YjJsdWRDSTZJbU5sYkd3dE5DMTFjeTEzWlhOMExUSXRNUzV3Y205a0xtRXVi\
Vzl0Wlc1MGIyaHhMbU52YlNJc0ltRndhVjlyWlhraU9pSmxlVXBvWWtkamFVOXBTa2xWZWtreFRtbEtPUzVsZVVwNlpGZEphVTlwU25kYVdGSnNURzFrYUd\
SWVVuQmFXRXBCV2pJeGFHRlhkM1ZaTWpsMFNXbDNhV1J0Vm5sSmFtOTRabEV1VW5OMk9GazVkRE5KVEMwd1RHRjZiQzE0ZDNaSVZESmZZalJRZEhGTlVVMD\
VRV3hhVlVsVGFrbENieUo5In0=".freeze

TEST_ENDPOINT = "testEndpoint".freeze
ENDPOINT_ENV_VAR = "MOMENTO_TEST_ENDPOINT".freeze
TEST_V2_API_KEY = "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ0IjoiZyIsImlkIjoic29tZS1pZC\
J9.WRhKpdh7cFCXO7lAaVojtQAxK6mxMdBrvXTJL1xu94S0d6V1YSstOObRlAIMA7i_yIxO1mWEF3rlF5UNc77V\
XQ".freeze
API_KEY_ENV_VAR = "MOMENTO_TEST_V2_API_KEY".freeze

RSpec.describe Momento::CredentialProvider do
  describe ".from_string" do
    context "when given a valid legacy API key" do
      it 'creates a CredentialProvider containing valid information' do
        credential_provider = described_class.from_string(LEGACY_API_KEY_VALID)
        expect(credential_provider.api_key).to eq(LEGACY_API_KEY_VALID)
        expect(credential_provider.control_endpoint).to eq(CONTROL_ENDPOINT_LEGACY)
        expect(credential_provider.cache_endpoint).to eq(CACHE_ENDPOINT_LEGACY)
      end
    end

    context "when given a valid V1 API key" do
      it 'creates a CredentialProvider containing valid information' do
        credential_provider = described_class.from_string(V1_API_KEY_VALID)
        expect(credential_provider.api_key).to eq(V1_INNER_KEY)
        expect(credential_provider.control_endpoint).to eq(CONTROL_ENDPOINT_V1)
        expect(credential_provider.cache_endpoint).to eq(CACHE_ENDPOINT_V1)
      end
    end

    context "when given an unparseable API key" do
      it "raises an InvalidArgumentError" do
        expect {
          described_class.from_string("this is not a key")
        }.to raise_error(Momento::Error::InvalidArgumentError)
      end
    end

    context "when given a legacy API key missing a control endpoint" do
      it 'raises an InvalidArgumentError' do
        expect {
          described_class.from_string(LEGACY_API_KEY_MISSING_CONTROL_ENDPOINT)
        }.to raise_error(Momento::Error::InvalidArgumentError)
      end
    end

    context "when given a legacy API key missing a cache endpoint" do
      it 'raises an InvalidArgumentError' do
        expect {
          described_class.from_string(LEGACY_API_KEY_MISSING_CACHE_ENDPOINT)
        }.to raise_error(Momento::Error::InvalidArgumentError)
      end
    end

    context "when given a v1 API key missing a key" do
      it 'raises an InvalidArgumentError' do
        expect {
          described_class.from_string(V1_API_KEY_MISSING_KEY)
        }.to raise_error(Momento::Error::InvalidArgumentError)
      end
    end

    context "when given a v1 API key missing an endpoint" do
      it 'raises an InvalidArgumentError' do
        expect {
          described_class.from_string(V1_API_KEY_MISSING_ENDPOINT)
        }.to raise_error(Momento::Error::InvalidArgumentError)
      end
    end

    context "when given a v2 API key" do
      it 'raises an InvalidArgumentError' do
        expect {
          described_class.from_string(TEST_V2_API_KEY)
        }.to raise_error(Momento::Error::InvalidArgumentError)
      end
    end
  end

  describe ".from_api_key_v2" do
    context "when given valid arguments" do
      it 'creates a CredentialProvider containing valid information' do
        credential_provider = described_class.from_api_key_v2(
          api_key: TEST_V2_API_KEY,
          endpoint: TEST_ENDPOINT
        )
        expect(credential_provider.api_key).to eq(TEST_V2_API_KEY)
        expect(credential_provider.control_endpoint).to eq("control.#{TEST_ENDPOINT}")
        expect(credential_provider.cache_endpoint).to eq("cache.#{TEST_ENDPOINT}")
      end
    end

    context "when given an empty api_key" do
      it 'raises an InvalidArgumentError' do
        expect {
          described_class.from_api_key_v2(api_key: "", endpoint: TEST_ENDPOINT)
        }.to raise_error(Momento::Error::InvalidArgumentError)
      end
    end

    context "when given a nil api_key" do
      it 'raises an InvalidArgumentError' do
        expect {
          described_class.from_api_key_v2(api_key: nil, endpoint: TEST_ENDPOINT)
        }.to raise_error(Momento::Error::InvalidArgumentError)
      end
    end

    context "when given an empty endpoint" do
      it 'raises an InvalidArgumentError' do
        expect {
          described_class.from_api_key_v2(api_key: TEST_V2_API_KEY, endpoint: "")
        }.to raise_error(Momento::Error::InvalidArgumentError)
      end
    end

    context "when given a nil endpoint" do
      it 'raises an InvalidArgumentError' do
        expect {
          described_class.from_api_key_v2(api_key: TEST_V2_API_KEY, endpoint: nil)
        }.to raise_error(Momento::Error::InvalidArgumentError)
      end
    end

    context "when given a v1 api key" do
      it 'raises an InvalidArgumentError' do
        expect {
          described_class.from_api_key_v2(api_key: V1_API_KEY_VALID, endpoint: nil)
        }.to raise_error(Momento::Error::InvalidArgumentError)
      end
    end

    context "when given a pre-v1 api key" do
      it 'raises an InvalidArgumentError' do
        expect {
          described_class.from_api_key_v2(api_key: LEGACY_API_KEY_VALID, endpoint: nil)
        }.to raise_error(Momento::Error::InvalidArgumentError)
      end
    end
  end

  describe ".from_env_var_v2" do
    context "when given valid arguments" do
      it 'creates a CredentialProvider containing valid information' do
        allow(ENV).to receive(:fetch).with(API_KEY_ENV_VAR).and_return(TEST_V2_API_KEY)
        allow(ENV).to receive(:fetch).with(ENDPOINT_ENV_VAR).and_return(TEST_ENDPOINT)
        credential_provider = described_class.from_env_var_v2(
          API_KEY_ENV_VAR,
          ENDPOINT_ENV_VAR
        )
        expect(credential_provider.api_key).to eq(TEST_V2_API_KEY)
        expect(credential_provider.control_endpoint).to eq("control.#{TEST_ENDPOINT}")
        expect(credential_provider.cache_endpoint).to eq("cache.#{TEST_ENDPOINT}")
      end
    end

    context "when the api key environment variable is not set" do
      it 'raises an InvalidArgumentError' do
        allow(ENV).to receive(:fetch).and_call_original
        allow(ENV).to receive(:fetch).with(ENDPOINT_ENV_VAR).and_return(TEST_ENDPOINT)
        expect {
          described_class.from_env_var_v2("NONEXISTENT_ENV_VAR", ENDPOINT_ENV_VAR)
        }.to raise_error(Momento::Error::InvalidArgumentError)
      end
    end

    context "when the endpoint environment variable is not set" do
      it 'raises an InvalidArgumentError' do
        allow(ENV).to receive(:fetch).and_call_original
        allow(ENV).to receive(:fetch).with(API_KEY_ENV_VAR).and_return(TEST_V2_API_KEY)
        expect {
          described_class.from_env_var_v2(API_KEY_ENV_VAR, "NONEXISTENT_ENV_VAR")
        }.to raise_error(Momento::Error::InvalidArgumentError)
      end
    end

    context "when the api key environment variable is set to an empty string" do
      it 'raises an InvalidArgumentError' do
        allow(ENV).to receive(:fetch).with(API_KEY_ENV_VAR).and_return("")
        allow(ENV).to receive(:fetch).with(ENDPOINT_ENV_VAR).and_return(TEST_ENDPOINT)
        expect {
          described_class.from_env_var_v2(API_KEY_ENV_VAR, ENDPOINT_ENV_VAR)
        }.to raise_error(Momento::Error::InvalidArgumentError)
      end
    end

    context "when the endpoint environment variable is set to an empty string" do
      it 'raises an InvalidArgumentError' do
        allow(ENV).to receive(:fetch).with(API_KEY_ENV_VAR).and_return(TEST_V2_API_KEY)
        allow(ENV).to receive(:fetch).with(ENDPOINT_ENV_VAR).and_return("")
        expect {
          described_class.from_env_var_v2(API_KEY_ENV_VAR, ENDPOINT_ENV_VAR)
        }.to raise_error(Momento::Error::InvalidArgumentError)
      end
    end

    context "when given a v1 api key" do
      it 'raises an InvalidArgumentError' do
        allow(ENV).to receive(:fetch).with(API_KEY_ENV_VAR).and_return(V1_API_KEY_VALID)
        allow(ENV).to receive(:fetch).with(ENDPOINT_ENV_VAR).and_return(TEST_ENDPOINT)
        expect {
          described_class.from_env_var_v2(API_KEY_ENV_VAR, ENDPOINT_ENV_VAR)
        }.to raise_error(Momento::Error::InvalidArgumentError)
      end
    end

    context "when given a pre-v1 api key" do
      it 'raises an InvalidArgumentError' do
        allow(ENV).to receive(:fetch).with(API_KEY_ENV_VAR).and_return(LEGACY_API_KEY_VALID)
        allow(ENV).to receive(:fetch).with(ENDPOINT_ENV_VAR).and_return(TEST_ENDPOINT)
        expect {
          described_class.from_env_var_v2(API_KEY_ENV_VAR, ENDPOINT_ENV_VAR)
        }.to raise_error(Momento::Error::InvalidArgumentError)
      end
    end
  end

  describe ".from_disposable_token" do
    context "when given a v1 api key" do
      it 'creates a CredentialProvider containing valid information' do
        credential_provider = described_class.from_disposable_token(V1_API_KEY_VALID)
        expect(credential_provider.api_key).to eq(V1_INNER_KEY)
        expect(credential_provider.control_endpoint).to eq(CONTROL_ENDPOINT_V1)
        expect(credential_provider.cache_endpoint).to eq(CACHE_ENDPOINT_V1)
      end
    end

    context "when given a pre-v1 api key" do
      it "creates a CredentialProvider containing valid information" do
        credential_provider = described_class.from_disposable_token(LEGACY_API_KEY_VALID)
        expect(credential_provider.api_key).to eq(LEGACY_API_KEY_VALID)
        expect(credential_provider.control_endpoint).to eq(CONTROL_ENDPOINT_LEGACY)
        expect(credential_provider.cache_endpoint).to eq(CACHE_ENDPOINT_LEGACY)
      end
    end

    context "when given a v2 api key" do
      it "raises an InvalidArgumentError" do
        expect {
          described_class.from_disposable_token(TEST_V2_API_KEY)
        }.to raise_error(Momento::Error::InvalidArgumentError)
      end
    end

    context "when given an empty token" do
      it "raises an InvalidArgumentError" do
        expect {
          described_class.from_disposable_token("")
        }.to raise_error(Momento::Error::InvalidArgumentError)
      end
    end
  end
end
