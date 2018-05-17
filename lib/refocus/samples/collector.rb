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

      def add(name:, aspect:, value:nil, messageBody:nil, messageCode:nil, relatedLinks:nil)
        samples << format_sample(name:name, aspect: aspect, value: value, messageBody: messageBody,
                                 messageCode: messageCode, relatedLinks: relatedLinks)
      end

      def upsert_bulk
        result = json(http.post("upsert/bulk", body: samples, expects: 200))
        samples.clear
        result
      end
      alias_method :submit, :upsert_bulk

      def format_sample(name:, aspect:, value:nil, messageBody:nil, messageCode:nil, relatedLinks:nil)
        sample = {name: "#{name}|#{aspect}"}
        sample[:value] = value.to_s if value
        sample[:messageBody] = messageBody.to_s if messageBody
        sample[:messageCode] = messageCode.to_s if messageCode
        sample[:relatedLinks] = relatedLinks if relatedLinks
        sample
      end

    end
  end
end