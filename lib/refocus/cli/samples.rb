require "refocus/cli"
require "json"

module Refocus
  class GetSampleCommand < Clamp::Command

    option ["-s", "--subject"], "SUBJECT", "subject to get a sample for", required: true
    option ["-a", "--aspect"], "ASPECT", "aspect to get a sample for", required: true

    def execute
      puts JSON.pretty_generate(Refocus.client.samples.get(subject: subject, aspect: aspect))
    end
  end

  Cli.class_eval do
    subcommand "samples:get", "Print a sample", GetSampleCommand
  end
end


