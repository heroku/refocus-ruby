require "refocus/cli"
require "refocus/cli/base"
require "json"
require "yaml"

module Refocus
  class ResourcesSyncCommand < BaseCommand

    option(["-a", "--action"], "ACTION", "action to perform: create or update", default: "create") do |s|
      (raise ArgumentError, "Invalid action: #{s}") unless %w{create update}.include?(s)
      s.to_sym
    end

    def execute
      input_subjects.each do |subject|
        subjects.send(action, {
          name: subject.fetch("name"),
          options: subject.fetch("properties")
        })
      end

      input_aspects.each do |aspect|
        aspects.send(action, {
          name: aspect.fetch("name"),
          options: aspect.fetch("properties")
        })
      end
    end

    def input
      @input ||= YAML.safe_load(STDIN.read)
    end

    def input_subjects
      input["subjects"] || []
    end

    def input_aspects
      input["aspects"] || []
    end
  end

  Cli.class_eval do
    subcommand "resources:sync", "Create refocus resources from STDIN", ResourcesSyncCommand
  end
end


