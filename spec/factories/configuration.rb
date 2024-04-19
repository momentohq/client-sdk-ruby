require 'momento/config/configurations'

FactoryBot.define do
  factory :configuration, class: "Momento::Configurations::Laptop" do
    initialize_with do
      Momento::Configurations::Laptop.latest
    end
  end
end
