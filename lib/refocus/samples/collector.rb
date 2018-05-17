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

      def add(name:, aspect:, value:nil, message_body:nil, message_code:nil, related_links:nil)
        samples << format_sample(name:name, aspect: aspect, value: value, message_body: message_body,
                                 message_code: message_code, related_links: related_links)
      end

      def upsert_bulk
        result = json(http.post("upsert/bulk", body: samples, expects: 200))
        samples.clear
        result
      end
      alias_method :submit, :upsert_bulk

      def format_sample(name:, aspect:, value:nil, message_body:nil, message_code:nil, related_links:nil)
        sample = {name: "#{name}|#{aspect}"}
        sample[:value] = value.to_s if value
        sample[:messageBody] = message_body if message_body
        sample[:messageCode] = message_code if message_code
        sample[:relatedLinks] = related_links if related_links
        sample
      end

    end
  end
end