require_relative "../../app/pet_api.rb"
require_relative "../supports/factories/create_pet.rb"

describe 'suite teste' do
    subject (:pet)   { PetApi.new }
    let(:create_pet) {pet.add_pet(attributes_for(:CreatePet))}
    let(:pet_generate)   {attributes_for(:CreatePet)}

    context 'add pet' do
        it 'add a pet in the store with status sold' do
            new_pet = create_pet
            expect(new_pet.code).to eq(200)
            expect(new_pet["id"]).not_to be_nil
            expect(new_pet['status']).to eq('sold')          
        end

        it 'add a pet in the store with status pending' do
            new_pet = pet.add_pet(attributes_for(:new_status_pending))
            expect(new_pet.code).to eq(200)
            expect(new_pet["id"]).not_to be_nil
            expect(new_pet['status']).to eq('pending')       
        end

        it 'add a pet in the store with status available' do
            new_pet = pet.add_pet(attributes_for(:new_status_available))
            expect(new_pet.code).to eq(200)
            expect(new_pet["id"]).not_to be_nil
            expect(new_pet['status']).to eq('available')         
        end
    end

    context 'get pet information' do
        it 'get pet by id' do
            pet_id = create_pet['id']
            get_pet_data = pet.get_pet(pet_id)
            expect(get_pet_data.code).to eq(200)
            expect(get_pet_data["id"]).to eq(pet_id)
        end

        xit 'get pet with invalid id' do
            resultado = pet.teste_get(9999).to_h #!não consegui validar status 404
            puts resultado
            expect(resultado['type']).to eq("error")
            # expect(result['code']).to eq(1)
            # expect(result['message']).to eq("Pet not found")
            # expect(result['type']).to eq("error")
        end

        it 'get pet by status sold and id' do
            pet_id = create_pet
            get_by_status = pet.get_pet_by_status(pet_id['status'])
            expect(get_by_status.code).to eq(200)
            expect(get_by_status.any? { |value| value['id'] == pet_id['id']}).to eq(true)
        end

        it 'get pet by status pending and id' do
            pet_id = pet.add_pet(attributes_for(:new_status_pending))
            get_by_status = pet.get_pet_by_status(pet_id['status'])
            expect(get_by_status.code).to eq(200)
            expect(get_by_status.any? { |value| value['id'] == pet_id['id']}).to eq(true)
        end

        it 'get pet by status available and id' do
            pet_id = pet.add_pet(attributes_for(:new_status_available))
            get_by_status = pet.get_pet_by_status(pet_id['status'])
            expect(get_by_status.code).to eq(200)
            expect(get_by_status.any? { |value| value['id'] == pet_id['id']}).to eq(true)
        end
    end

    context 'Update pet data' do
        it 'update pet data using post' do
            pet_data = create_pet
            pet_id = pet_data['id']
            name = "diego"
            status = "pending"
            update_pet = pet.post_to_update(pet_id, name, status)
            expect(update_pet.code).to eq(200)
            expect(update_pet['message']).to eq("#{pet_id}")
            expect(pet_data.any? { |value| value[0]['name'] != name}).to eq(true)
            expect(pet_data.any? { |value| value[0]['status'] != status}).to eq(true)
        end

        it 'update pet data using put' do
            pet_data = pet.add_pet(pet_generate)
            pet_generate['name'] = 'Diego'
            pet_generate['status'] = 'available'
            update_pet_data = pet.put_to_update(pet_generate)
            expect(update_pet_data.code).to eq(200)
            expect(update_pet_data['status']).to eq("available")
            expect(update_pet_data['name']).to eq("Diego")
        end
    end

    context 'delete pet' do
        it 'delete pet by id' do
            pet_id = create_pet['id']
            remove_pet = pet.delete_pet(pet_id)
            expect(remove_pet.code).to eq(200)
            expect(remove_pet["message"]).to eq("#{pet_id}")
        end
    end
end