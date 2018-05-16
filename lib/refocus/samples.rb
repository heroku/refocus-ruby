require "refocus/http"
require "refocus/json_helper"

module Refocus
  class Samples
    include JsonHelper

    attr_reader :http, :samples

    def initialize(url:, token:)
      @http = Refocus::Http.new(url: url, token: token)
      @samples = []
    end

    def collector
      Collector.new(http: http)
    end

    def upsert(name:, aspect:, value:"", messageBody:"", messageCode:"", relatedLinks:[])
      sample = format_sample(name:name, aspect: aspect, value: value, messageBody: messageBody, messageCode: messageCode, relatedLinks: relatedLinks)
      json(http.post("upsert", body: sample, expects: 200))
    end
    alias_method :submit, :upsert

    def upsert_custom_body(custom_body)
      endpoint = (custom_body.is_a? Array) ? "upsert/bulk" : "upsert"
      json(http.post(endpoint, body: custom_body, expects: 200))
    end

    def list(limit: nil)
      params = ""
      params = params + "?limit=#{limit}" if limit
      json(http.get(params))
    end

    def get(subject:, aspect:)
      json(http.get(URI.escape("#{subject}\|#{aspect}")))
    end

    private
    def format_sample(name:, aspect:, value:"", messageBody:"", messageCode:"", relatedLinks:[])
      {name: "#{name}|#{aspect}", value: value.to_s, messageBody: messageBody, messageCode: messageCode, relatedLinks: relatedLinks}
    end

  end
end