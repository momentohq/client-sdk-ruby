require 'momento/config/configurations'

FactoryBot.define do
  factory :configuration, class: "Momento::Cache::Configurations::Laptop" do
    initialize_with do
      Momento::Cache::Configurations::Laptop.latest
    end
  end
end
