require 'jwt'

FactoryBot.define do
  factory :auth_token, class: "JWT" do
    transient do
      sub { Faker::Internet.email }
      cp { Faker::Internet.domain_name }
      c { Faker::Internet.domain_name }
      algorithm { "HS512" }
      secret { Faker::Internet.base64 }
    end

    payload do
      {
        sub: sub,
        cp: cp,
        c: c
      }
    end

    initialize_with do
      JWT.encode(payload, secret, algorithm)
    end
  end
end
