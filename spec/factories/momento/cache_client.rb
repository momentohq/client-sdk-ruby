FactoryBot.define do
  factory(
    :momento_cache_client_delete_response,
    class: MomentoProtos::CacheClient::PB__DeleteResponse
  ) do
    initialize_with { new(**attributes) }
  end

  factory(
    :momento_cache_client_get_response,
    class: MomentoProtos::CacheClient::PB__GetResponse
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

    trait :invalid do
      result { :Invalid }
    end

    initialize_with { new(**attributes) }
  end

  factory(
    :momento_cache_client_set_response,
    class: MomentoProtos::CacheClient::PB__SetResponse
  ) do
    result { :Ok }
    message { "" }

    initialize_with { new(**attributes) }
  end
end
