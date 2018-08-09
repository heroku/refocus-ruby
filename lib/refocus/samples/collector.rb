require "refocus/json_helper"

module Refocus
  class Samples
    class Collector
      include JsonHelper

      attr_reader :http, :samples, :job_id

      def initialize(http:)
        @http = http
        @samples = []
      end

      def add(name:, aspect:, value:nil, message_body:nil, message_code:nil, related_links:nil)
        samples << self.class.format_sample(name:name, aspect: aspect, value: value, message_body: message_body,
                                 message_code: message_code, related_links: related_links)
      end

      def upsert_bulk
        result = json(http.post("upsert/bulk", body: samples, expects: 200))
        samples.clear
        result
      end
      alias_method :submit, :upsert_bulk

      def check_status(upsert_bulk_response)
        job_id = upsert_bulk_response["jobId"]
        if job_id
          json(http.get("upsert/bulk/#{job_id}/status"))
        else
          warn "The jobId was not found in the previous upsert_bulk_response - #{upsert_bulk_response} - Status cannot be checked."
          "{}" # return empty json
        end
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