FactoryBot.define do
  factory(
    :momento_cache_client_delete_response,
    class: "Momento::CacheClient::DeleteResponse"
  ) do
    initialize_with { new(**attributes) }
  end

  factory(
    :momento_cache_client_get_response,
    class: "Momento::CacheClient::GetResponse"
  ) do
    cache_body { "" }
    message { "" }

    trait :hit do
      result { :Hit }
      cache_body { Faker::Lorem.sentence }
    end

    trait :miss do
      result { :Miss }
      message { "Item not found" }
    end

    initialize_with { new(**attributes) }
  end

  factory(
    :momento_cache_client_set_response,
    class: "Momento::CacheClient::SetResponse"
  ) do
    result { :Ok }
    message { "" }

    initialize_with { new(**attributes) }
  end
end
