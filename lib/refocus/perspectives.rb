require "refocus/http"
require "refocus/json_helper"
module Refocus
  class Perspectives
    include JsonHelper

    attr_reader :http

    def initialize(url:, token:)
      @http = Refocus::Http.new(url: url, token: token)
    end

    def all
      json(http.get(""))
    end

    def get(name:)
      json(http.get(name))
    end

    def create(name:, lens:, root_subject:)
      body = {
        "name" => name,
        "lensId" => lens,
        "rootSubject" => root_subject
      }
      json(http.post("", body: body))
    end
  end
end
