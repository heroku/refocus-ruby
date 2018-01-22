require "refocus/cli/base"
module Refocus

  class AspectsGetCommand < BaseCommand
    parameter "ASPECT", "aspect to describe"
    def execute
      puts JSON.pretty_generate(aspects.get(name: aspect))
    end
  end

  class AspectsDeleteCommand< BaseCommand
    parameter "ASPECT", "aspect to delete"
    def execute
      aspects.delete(name: aspect)
    end
  end

  Cli.class_eval do
    subcommand "aspects:delete", "Delete an aspect", Refocus::AspectsDeleteCommand
    subcommand "aspects:get", "Get an aspect. Prints out JSON.", Refocus::AspectsGetCommand
  end
end

