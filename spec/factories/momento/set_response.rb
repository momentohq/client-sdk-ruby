FactoryBot.define do
  factory(
    :momento_set_response_success,
    class: "Momento::SetResponse::Success"
  ) do
    momento_response
  end

  factory(
    :momento_set_response_error,
    class: "Momento::SetResponse::Error"
  ) do
    momento_response_error
  end
end
