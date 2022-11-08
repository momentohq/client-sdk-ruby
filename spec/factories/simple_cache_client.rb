FactoryBot.define do
  factory :momento_simple_cache_client, class: "Momento::SimpleCacheClient" do
    auth_token { build(:auth_token) }

    initialize_with do
      Momento::SimpleCacheClient.new(auth_token: auth_token)
    end
  end
end
