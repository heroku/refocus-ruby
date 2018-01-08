require "refocus/http"
module Refocus
  class Samples
    attr_reader :http

    def initialize(url:, token:)
      @http = Refocus::Http.new(url: url, token: token)
    end

    def collector
      Collector.new(http: http)
    end
  end
end

require "refocus/samples/collector"

