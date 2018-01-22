require "refocus/cli"
require "refocus/cli/base"
require "json"

module Refocus
  class GetSampleCommand < BaseCommand
    parameter "SAMPLE", "Sample to get, in the format SUBJECT|SAMPLE. Use quotes to avoid bash interpreting |." do |s|
      s.tap do |s|
        (raise ArgumentError, "Invalid sample: #{s}") unless s.split("|").size == 2
      end
    end

    def execute
      puts JSON.pretty_generate(Refocus.client.samples.get(subject: subject, aspect: aspect))
    end

    def sample_array
      sample.split("|")
    end

    def subject
      sample_array.first
    end

    def aspect
      sample_array.last
    end
  end

  Cli.class_eval do
    subcommand "samples:get", "Print a sample", GetSampleCommand
  end
end


