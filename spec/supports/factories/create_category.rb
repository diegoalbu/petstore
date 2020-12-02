require_relative '../models/create_category.rb'

FactoryBot.define do
    factory :CreateCategory, class: ModelCreateCategory  do
        id        {}
        name      {Faker::Creature::Dog.breed}
    end
end