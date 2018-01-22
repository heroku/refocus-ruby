module Refocus

  class SubjectsGetCommand < BaseCommand
    parameter "SUBJECT", "subject to describe"
    def execute
      puts JSON.pretty_generate(refocus.subjects.get(name: subject))
    end
  end

  class SubjectsDeleteCommand < BaseCommand
    parameter "SUBJECT", "subject to delete"
    def execute
      refocus.subjects.delete(name: subject)
    end
  end

  Cli.class_eval do
    subcommand "subjects:delete", "Delete a subject", Refocus::SubjectsDeleteCommand
    subcommand "subjects:get", "Get a subject. Prints out JSON.", Refocus::SubjectsGetCommand
  end end

