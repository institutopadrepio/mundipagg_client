# frozen_string_literal: true

require_relative "lib/mundipagg_client/version"

Gem::Specification.new do |spec|
  spec.name          = "mundipagg_client"
  spec.version       = MundipaggClient::VERSION
  spec.authors       = ["Instituto Padre Pio"]
  spec.email         = ["santosjr87@gmail.com"]

  spec.summary       = "Wrapper for Mundipagg API."
  spec.description   = "Client for Mundipagg Payment Gateway."
  spec.homepage      = "http://padrepauloricardo.org"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "nokogiri", ">= 1.12.5"
  spec.add_development_dependency "addressable", ">= 2.8.0"
  spec.add_development_dependency "rake",    "~> 12.3.3"
  spec.add_development_dependency "rspec",   "~> 3.7"
  spec.add_runtime_dependency "active_interaction", "~> 4.0"
  spec.add_dependency "excon", ">= 0.73.0"
  spec.add_dependency "faraday"
  spec.add_development_dependency "pry", "~> 0.13.1"
  spec.add_development_dependency "solargraph", "~> 0.42.3"
  spec.add_development_dependency "vcr",     "~> 5.1"
  spec.add_development_dependency "webmock", "~> 3.8"
end
