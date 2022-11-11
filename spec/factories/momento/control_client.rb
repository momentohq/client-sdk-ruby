FactoryBot.define do
  factory(
    :momento_control_client_cache,
    class: "Momento::ControlClient::Cache"
  ) do
    cache_name { Faker::Lorem.word }
  end

  factory(
    :momento_control_client_list_caches_response,
    class: "Momento::ControlClient::ListCachesResponse"
  ) do
    transient do
      num_caches { 3 }
      cache_names {
        (1..num_caches).map { Faker::Lorem.word }
      }
    end

    cache do
      cache_names.map do |name|
        build(:momento_control_client_cache, cache_name: name)
      end
    end

    next_token { "" }

    initialize_with do
      Momento::ControlClient::ListCachesResponse.new(
        cache: cache, next_token: next_token
      )
    end
  end
end
