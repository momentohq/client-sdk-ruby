FactoryBot.define do
  factory(
    :momento_delete_cache_response_success,
    class: "Momento::DeleteCacheResponse::Success"
  ) do
    momento_response
  end

  factory(
    :momento_delete_cache_response_error,
    class: "Momento::DeleteCacheResponse::Error"
  ) do
    momento_response_error
  end
end
