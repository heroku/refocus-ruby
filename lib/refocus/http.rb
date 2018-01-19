require "refocus/errors"

module Refocus
  class Http

    attr_reader :url, :token, :content_type

    def initialize(url:, token:, content_type: "application/json")
      @url = url
      @token = token
      @content_type = content_type
    end

    def post(path, body:, expects: 201)
      handle { connection(path).post(body: convert(body), headers: headers, expects: expects) }
    end

    def get(path)
      handle { connection(path).get(headers: headers, expects: 200) }
    end

    def patch(path, body:)
      handle { connection(path).patch(body: convert(body), headers: headers, expects: 200) }
    end

    def put(path, body:)
      handle { connection(path).put(body: convert(body), headers: headers, expects: 201) }
    end

    def delete(path)
      handle { connection(path).delete(headers: headers, expects: 200) }
    end

    def handle(&block)
      yield
    rescue Excon::Error::BadRequest => e
      response = JSON.parse(e.response.body)["errors"].first["message"]
      raise ApiError, JSON.parse(e.response.body)
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
