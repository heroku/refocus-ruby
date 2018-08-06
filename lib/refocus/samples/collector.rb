require "refocus/json_helper"

module Refocus
  class Samples
    class Collector
      include JsonHelper

      attr_reader :http, :samples, :job_id

      def initialize(http:)
        @http = http
        @samples = []
        @job_id = nil
      end

      def add(name:, aspect:, value:nil, message_body:nil, message_code:nil, related_links:nil)
        samples << self.class.format_sample(name:name, aspect: aspect, value: value, message_body: message_body,
                                 message_code: message_code, related_links: related_links)
      end

      def upsert_bulk
        result = json(http.post("upsert/bulk", body: samples, expects: 200))
        @job_id = result["jobId"]
        samples.clear
        result
      end
      alias_method :submit, :upsert_bulk

      def check_status
        json(http.get("upsert/bulk/#{job_id}/status"))
      end

      def self.format_sample(name:, aspect:, value:nil, message_body:nil, message_code:nil, related_links:nil)
        sample = {name: "#{name}|#{aspect}"}
        sample[:value] = value.to_s if value
        sample[:messageBody] = message_body.to_s if message_body
        sample[:messageCode] = message_code.to_s if message_code
        sample[:relatedLinks] = related_links if related_links
        sample
      end

    end
  end
end