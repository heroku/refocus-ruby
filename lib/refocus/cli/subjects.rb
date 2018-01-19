module Refocus
  class SubjectsDeleteCommand< Clamp::Command
    parameter "SUBJECT", "subject to delete"

    def execute
      refocus.subjects.delete(name: subject)
    end

    def refocus
      Refocus.client
    end
  end

  Cli.class_eval do
    subcommand "subjects:delete", "Delete a subject", Refocus::SubjectsDeleteCommand
  end
end

