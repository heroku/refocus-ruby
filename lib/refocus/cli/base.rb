require "clamp"

module Refocus
  class BaseCommand < Clamp::Command
    def refocus
      Refocus.client
    end

    def aspects
      Refocus.client.aspects
    end

    def subjects
      Refocus.client.subjects
    end

    def samples
      Refocus.client.samples
    end
  end
end
