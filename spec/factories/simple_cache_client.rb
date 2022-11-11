FactoryBot.define do
  factory :momento_simple_cache_client, class: "Momento::SimpleCacheClient" do
    auth_token { build(:auth_token) }
    default_ttl { 10_000 }

    initialize_with do
      Momento::SimpleCacheClient.new(**attributes)
    end
  end
end
