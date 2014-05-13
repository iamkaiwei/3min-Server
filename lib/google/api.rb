module Google
  class Api
    BASE_URL = 'https://www.googleapis.com/plus/v1'

    attr_reader :access_token

    def initialize access_token
      @access_token = access_token
    end

    def user_info
      url = BASE_URL + "/people/me?access_token=#{access_token}"
      RestClient.get(url){ |response, request, result| Google::Response.new(response) }
    end
  end
end