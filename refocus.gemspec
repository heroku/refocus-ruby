
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "refocus/version"

Gem::Specification.new do |spec|
  spec.name          = "refocus"
  spec.version       = Refocus::VERSION
  spec.authors       = ["Michael Shea"]
  spec.email         = ["michael.shea@heroku.com"]

  spec.summary       = %q{Refocus ruby client}
  spec.description   = %q{Ruby client for https://github.com/salesforce/refocus}
  spec.homepage      = "https://github.com/heroku/refocus-ruby"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = ["refocus"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
  spec.add_dependency "excon"
  spec.add_dependency "clamp"
end
