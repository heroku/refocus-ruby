require "refocus/json_helper"

module Refocus
  class Samples
    class Collector
      include JsonHelper

      attr_reader :http, :samples

      def initialize(http:)
        @http = http
        @samples = []
      end

      def add(name:, aspect:, value:"", messageBody:"", messageCode:"", relatedLinks:[])
        samples << {name: "#{name}|#{aspect}", value: value.to_s, messageBody: messageBody, messageCode: messageCode, relatedLinks: relatedLinks}
      end

      def upsert_bulk
        result = json(http.post("upsert/bulk", body: samples, expects: 200))
        samples.clear
        result
      end
      alias_method :submit, :upsert_bulk

    end
  end
end