require_relative "../../app/pet_api.rb"
require_relative "../supports/factories/create_pet.rb"

describe 'suite teste' do
    subject (:pet) { PetApi.new }
    let(:create_pet) {pet.add_pet(attributes_for(:CreatePet))}
    let(:update_pet_data) {attributes_for(:CreatePet)}

    context 'add pet' do
        it 'add a pet in the store' do
            pet = create_pet
            expect(pet.code).to eq(200)
            expect(pet["id"]).not_to be_nil          
        end
    end

    context 'get pet information' do
        it 'get pet by id' do
            petid = create_pet['id']
            result = pet.get_pet(petid)
            expect(result.code).to eq(200)
            expect(result["id"]).to eq(petid)
        end

        it 'get pet with invalid id' do
            result = pet.teste_get
            expect(result[0]["type"]).to eq("error")
            # expect(result['code']).to eq(1)
            # expect(result['message']).to eq("Pet not found")
            # expect(result['type']).to eq("error")
        end

        it 'get pet by status and id' do
            petid = create_pet
            get_by_status = pet.get_pet_by_status(petid['status'])
            expect(get_by_status.code).to eq(200)
            expect(get_by_status.any? { |value| value['id'] == petid['id']}).to eq(true)
        end
    end

    context 'Update pet data' do
        it 'update pet data using post' do
            pet_data = create_pet
            petid = pet_data['id']
            name = "diego"
            status = "pending"
            update_pet = pet.post_to_update(petid, name, status)
            expect(update_pet.code).to eq(200)
            expect(update_pet['message']).to eq("#{petid}")
            expect(pet_data.any? { |value| value[0]['name'] != name}).to eq(true)
            expect(pet_data.any? { |value| value[0]['status'] != status}).to eq(true)
        end

        it 'update pet data using put' do
            update_pet_data = pet.put_to_update(update_pet_data)
            expect(update_pet_data.code).to eq(200)
        end
    end

    context 'delete pet' do
        it 'delete pet by id' do
            petid = create_pet['id']
            result = pet.delete_pet(petid)
            expect(result.code).to eq(200)
            expect(result["message"]).to eq("#{petid}")
        end
    end
end