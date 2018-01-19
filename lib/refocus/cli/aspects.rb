module Refocus
  class AspectsDeleteCommand< Clamp::Command
    parameter "ASPECT", "aspect to delete"

    def execute
      refocus.aspects.delete(name: aspect)
    end

    def refocus
      Refocus.client
    end
  end

  Cli.class_eval do
    subcommand "aspects:delete", "Delete an aspect", Refocus::AspectsDeleteCommand
  end
end

