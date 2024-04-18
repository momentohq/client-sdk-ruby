FactoryBot.define do
  factory(
    :momento_control_client_cache,
    class: MomentoProtos::ControlClient::PB__Cache
  ) do
    cache_name { Faker::Lorem.word }
  end

  factory(
    :momento_control_client_list_caches_response,
    class: MomentoProtos::ControlClient::PB__ListCachesResponse
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
      MomentoProtos::ControlClient::PB__ListCachesResponse.new(
        cache: cache, next_token: next_token
      )
    end
  end
end
