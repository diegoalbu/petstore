class PetApi

    def teste_get
        url = URI("https://petstore.swagger.io/v2/pet/922337203685477580")
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

    def get_pet(petid)
        uri = "#{ENV['BASE_URI']}/pet/#{petid}"
        response = without_authentication('get', uri)
    end

    def get_pet_by_status(status_id)
        uri = "#{ENV['BASE_URI']}/pet/findByStatus?status=#{status_id}"
        response = without_authentication('get', uri)
    end

    def delete_pet(petid)
        uri = "#{ENV['BASE_URI']}/pet/#{petid}"
        response = without_authentication('delete', uri)
    end
end