FactoryBot.define do
  factory(
    :momento_list_caches_response_caches,
    class: "Momento::ListCachesResponse::Caches"
  ) do
    momento_response

    grpc_response {
      build(:momento_control_client_list_caches_response)
    }
  end

  factory(
    :momento_list_caches_response_error,
    class: "Momento::ListCachesResponse::Error"
  ) do
    momento_response_error
  end
end
