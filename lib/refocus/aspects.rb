require "refocus/http"
module Refocus
  class Aspects
    attr_reader :http

    def initialize(url:, token:)
      @http = Refocus::Http.new(url: url, token: token)
    end

    def all
      json(http.get(""))
    end

    def create(parent: nil, name:, options: {} )
      path = parent ? "#{parent}/child" : ""
      body =  default_options.merge("name" => name).merge(options)
      json(http.post(path, body: body))
    end

    def delete(name:)
      json(http.delete(name))
    end

    def get(name:)
      json(http.get(name))
    end

    def json(response)
      JSON.parse(response.body)
    end

    def default_options
      {
        "timeout" => "5m"
      }
    end
  end
end
