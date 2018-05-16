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

    def upsert(name:, aspect:, value:"", messageBody:"", messageCode:"", relatedLinks:[])
      sample = format_sample(name:name, aspect: aspect, value: value, messageBody: messageBody, messageCode: messageCode, relatedLinks: relatedLinks)
      json(http.post("upsert", body: sample, expects: 200))
    end

    def add_to_bulk(name:, aspect:, value:"", messageBody:"", messageCode:"", relatedLinks:[])
      samples << format_sample(name:name, aspect: aspect, value: value, messageBody: messageBody, messageCode: messageCode, relatedLinks: relatedLinks)
    end

    def upsert_bulk
      if samples.empty?
        raise Exception, "No samples to upsert have been added. Please use the add_to_bulk method to add samples to upsert first."
      else
        result = json(http.post("upsert/bulk", body: samples, expects: 200))
        samples.clear
        result
      end
    end

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