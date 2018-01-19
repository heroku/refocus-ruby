require "refocus/cli"
require "json"
require "yaml"

module Refocus
  class ResourcesSyncCommand < Clamp::Command

    option(["-a", "--action"], "ACTION", "action to perform: create or update", default: "create") do |s|
      (raise ArgumentError, "Invalid action: #{s}") unless %w{create update}.include?(s)
      s.to_sym
    end

    def execute
      subjects.each do |subject|
        refocus.subjects.send(action, {
          name: subject.fetch("name"),
          options: subject.fetch("properties")
        })
      end

      aspects.each do |aspect|
        refocus.aspects.send(action, {
          name: aspect.fetch("name"),
          options: aspect.fetch("properties")
        })
      end
    end

    def input
      @input ||= YAML.safe_load(STDIN.read)
    end

    def subjects
      input["subjects"] || []
    end

    def aspects
      input["aspects"] || []
    end

    def refocus
      Refocus.client
    end
  end

  Cli.class_eval do
    subcommand "resources:sync", "Create refocus resources from STDIN", ResourcesSyncCommand
  end
end


