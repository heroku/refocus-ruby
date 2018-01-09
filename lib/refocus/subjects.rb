require "refocus/http"
require "refocus/json_helper"
require "refocus/path_helper"

module Refocus
  class Subjects
    include JsonHelper
    include PathHelper

    attr_reader :http

    def initialize(url:, token:)
      @http = Refocus::Http.new(url: url, token: token)
    end

    def all
      json(http.get(""))
    end

    def create(name:, options: {})
      parent, child = parent_and_name(name)
      path = parent ? "#{parent}/child" : ""
      body = options.merge({"name" => child})
      json(http.post(path, body: body))
    end

    def delete(name:)
      json(http.delete(name))
    end

    def get(name:)
      json(http.get(name))
    end
  end
end
