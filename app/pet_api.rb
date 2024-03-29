class PetApi

    def teste_get(petid)
        url = URI("https://petstore.swagger.io/v2/pet/#{petid}")
        https = Net::HTTP.new(url.host, url.port)
        https.use_ssl = true
        request = Net::HTTP::Get.new(url)
        request["accept"] = "application/json"
        response = https.request(request)
        puts response.read_body
    end

    def add_pet(body)
        uri = "#{ENV['BASE_URI']}/pet"
        response = without_authentication('post', uri, body.to_json)
    end

    def get_pet(pet_id)
        uri = "#{ENV['BASE_URI']}/pet/#{pet_id}"
        response = without_authentication('get', uri)
    end

    def get_pet_by_status(status_id)
        uri = "#{ENV['BASE_URI']}/pet/findByStatus?status=#{status_id}"
        response = without_authentication('get', uri)
    end

    def post_to_update(pet_id, name, status)
        uri = "#{ENV['BASE_URI']}/pet/#{pet_id}"
        body = "name=#{name}&status=#{status}"
        response = without_authentication('post', uri, body, 'application/x-www-form-urlencoded')
    end

    def put_to_update(body)
        uri = "#{ENV['BASE_URI']}/pet"
        response = without_authentication('put', uri, body.to_json)
    end

    def delete_pet(pet_id)
        uri = "#{ENV['BASE_URI']}/pet/#{pet_id}"
        response = without_authentication('delete', uri)
    end
end