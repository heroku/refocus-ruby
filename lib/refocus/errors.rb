module Refocus
  class ApiError < StandardError
    attr_reader :json
    def initialize(json)
      @json = json
      super("#{json["errors"].first["message"]}:#{json["errors"].first["description"]}")
    end
  end
end
