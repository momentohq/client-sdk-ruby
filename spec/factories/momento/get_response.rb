FactoryBot.define do
  factory(
    :momento_get_response_hit,
    class: "Momento::GetResponse::Hit"
  ) do
    transient do
      value { Faker::Lorem.sentence }
    end

    momento_response

    grpc_response {
      build(:momento_cache_client_get_response, :hit, cache_body: value)
    }
  end

  factory(
    :momento_get_response_miss,
    class: "Momento::GetResponse::Miss"
  ) do
    momento_response
  end

  factory(
    :momento_get_response_error,
    class: "Momento::GetResponse::Error"
  ) do
    momento_response_error
  end
end
