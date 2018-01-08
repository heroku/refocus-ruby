module Refocus
  class Http

    attr_reader :url, :token, :content_type

    def initialize(url:, token:, content_type: "application/json")
      @url = url
      @token = token
      @content_type = content_type
    end

    def post(path, body:)
      connection(path).post(body: convert(body), headers: headers, expects: 201)
    end

    def get(path)
      connection(path).get(headers: headers, expects: 200)
    end

    def delete(path)
      connection(path).delete(headers: headers, expects: 200)
    end

    def headers
      {
        "Authorization" => token,
        "Content-Type" => content_type
      }
    end

    def convert(body)
      content_type == "application/json" ? body.to_json : body
    end

    def connection(path)
      Excon.new("#{url}/#{path}")
    end
  end
end
