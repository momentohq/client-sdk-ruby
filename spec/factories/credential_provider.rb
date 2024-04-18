FactoryBot.define do
  factory :credential_provider, class: "Momento::CredentialProvider" do
    api_key { build(:auth_token) }

    initialize_with do
      Momento::CredentialProvider.from_string(api_key)
    end
  end
end
