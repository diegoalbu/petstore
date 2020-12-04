require_relative '../models/create_pet.rb'
require_relative '../factories/create_tag.rb'
require_relative '../factories/create_category.rb'

FactoryBot.define do
    factory :CreatePet, class: ModelCreatePet  do
        id        {Faker::Number.number(digits: 10)}
        category  {attributes_for(:CreateCategory)}
        name      {Faker::Name.neutral_first_name}
        photoUrls {[Faker::Internet.url]}
        tags      {[attributes_for(:CreateTag)]}
        status    {"sold"}   

        trait :status_available do
            status { "available"}
        end

        trait :status_pending do
            status { "pending" }
        end

        factory :new_status_pending,   traits: [:status_pending]
        factory :new_status_available, traits: [:status_available]
    end
end
