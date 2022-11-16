FactoryBot.define do
  factory(
    :momento_create_cache_response_already_exists,
    class: "Momento::CreateCacheResponse::AlreadyExists"
  ) do
    momento_response
  end

  factory(
    :momento_create_cache_response_success,
    class: "Momento::CreateCacheResponse::Success"
  ) do
    momento_response
  end

  factory(
    :momento_create_cache_response_error,
    class: "Momento::CreateCacheResponse::Error"
  ) do
    momento_response_error
  end
end
