FactoryBot.define do
  factory(
    :momento_delete_response_success,
    class: "Momento::DeleteResponse::Success"
  ) do
    momento_response
  end

  factory(
    :momento_delete_response_error,
    class: "Momento::DeleteResponse::Error"
  ) do
    momento_response_error
  end
end
