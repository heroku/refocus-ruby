require "excon"
require "json"
require "refocus/aspects"
require "refocus/subjects"
require "refocus/samples"
require "refocus/lenses"

module Refocus
  class Client
    API_PATH = "v1"

    attr_reader :url, :token, :debug_request, :debug_response

    def initialize(url:, token:, debug_request: false, debug_response: false)
      @url = url
      @token = token
      @debug_request = debug_request
      @debug_response = debug_response
    end

    def subjects
      Refocus::Subjects.new(url: "#{url}/v1/subjects", token: token)
    end

    def aspects
      Refocus::Aspects.new(url: "#{url}/v1/aspects", token: token)
    end

    def samples
      Refocus::Samples.new(url: "#{url}/v1/samples", token: token)
    end

    def lenses
      Refocus::Lenses.new(url: "#{url}/v1/lenses", token: token)
    end

  end
end
