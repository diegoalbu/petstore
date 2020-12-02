require_relative '../models/create_tag.rb'

FactoryBot.define do
    factory :CreateTag, class: ModelCreateTag  do
        id        {}
        name      {Faker::Name.neutral_first_name}
    end
end