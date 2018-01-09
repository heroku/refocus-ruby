module Refocus
  module PathHelper
    # Given a dot-separated string, returns the parent and name.
    # Returns nil for parent if there are no dots.
    def parent_and_name(name)
      array = name.split(".")
      parent = array.length == 1 ? nil : array[0..-2].join(".")
      name = array[-1]
      [parent, name]
    end
  end
end
