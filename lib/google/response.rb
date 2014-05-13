module Google
  class Response
    attr_reader :response

    def initialize raw_json
      @response = JSON.parse(raw_json, symbolize_names: true)
    end

    def success?
      error.blank?
    end

    def error
      response[:error]
    end

    def method_missing method, *args, &block
      response.send(method, *args)
    end
  end
end