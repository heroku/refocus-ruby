module Refocus
  class Samples
    class Collector

      attr_reader :http, :samples

      def initialize(http:)
        @http = http
        @samples = []
      end

      def add(name:, aspect:, value:)
        samples << {name: "#{name}|#{aspect}", value: value.to_s}
      end

      def submit
        result = json(http.post("upsert/bulk", body: samples))
        samples.clear
        true
      end

      def json(response)
        JSON.parse(response.body)
      end
    end
  end
end
