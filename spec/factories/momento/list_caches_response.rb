FactoryBot.define do
  factory(
    :momento_list_caches_response_success,
    class: "Momento::ListCachesResponse::Success"
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
