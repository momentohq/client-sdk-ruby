FactoryBot.define do
  factory :momento_simple_cache_client, class: "Momento::SimpleCacheClient" do
    credential_provider { build(:credential_provider) }
    default_ttl { 10_000 }

    initialize_with do
      Momento::SimpleCacheClient.new(**attributes)
    end
  end
end
