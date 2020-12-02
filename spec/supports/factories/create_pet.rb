require_relative '../models/create_pet.rb'
require_relative '../factories/create_tag.rb'
require_relative '../factories/create_category.rb'

FactoryBot.define do
    factory :CreatePet, class: ModelCreatePet  do
        id        {0}
        category  {attributes_for(:CreateCategory)}
        name      {Faker::Name.neutral_first_name}
        photoUrls {}
        tags      {[attributes_for(:CreateTag)]}
        status    {"sold"}        
    end
end

#     trait :available do
#         status { "available"}
#     end

#     trait :pending do
#         status { "pending" }
#     end

#     trait :sold do
#         status { "sold" }
#     end
# end

    # trait do
    #     status { "sold" }
    # end