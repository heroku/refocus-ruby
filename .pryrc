$: << "lib"
require "refocus"

def refocus
  @refocus ||= Refocus.client
end
