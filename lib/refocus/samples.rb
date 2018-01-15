require "refocus/http"
require "refocus/json_helper"

module Refocus
  class Samples
    include JsonHelper

    attr_reader :http

    def initialize(url:, token:)
      @http = Refocus::Http.new(url: url, token: token)
    end

    def collector
      Collector.new(http: http)
    end

    def submit(name:, aspect:, value:)
      c = collector
      c.add(name: name, aspect: aspect, value: value)
      c.submit
    end

    def list(limit: nil)
      params = ""
      params = params + "?limit=#{limit}" if limit
      json(http.get(params))
    end

    def get(subject:, aspect:)
      json(http.get(URI.escape("#{subject}\|#{aspect}")))
    end
  end
end

require "refocus/samples/collector"

