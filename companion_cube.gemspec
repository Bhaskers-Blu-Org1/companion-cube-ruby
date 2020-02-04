# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "companion_cube/version"

Gem::Specification.new do |spec|
  spec.name        = "companion_cube"
  spec.version     = CompanionCube::VERSION
  spec.date        = Time.now
  spec.summary     = "Companion Cube client"
  spec.description = spec.summary
  spec.authors     = ["Partner Ecosystem Team, IBM Digital Business Group"]
  spec.email       = ["imcloud@ca.ibm.com"]

  spec.files         = Dir.glob("{bin,lib}/**/*") + %w[CHANGELOG.md LICENSE README.md]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.homepage      = "https://github.ibm.com/bdu/companion-cube-ruby"
  spec.license       = "All rights reserved."

  unless spec.respond_to?(:metadata)
    raise "RubyGems 2.0 or newer required to protect against public gem pushes"
  end

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the
  # "allowed_push_host" to allow pushing to a single host or delete this
  # section to allow pushing to any host.
  spec.metadata["allowed_push_host"] =
    "https://na.artifactory.swg-devops.com/artifactory/api/gems/apset-ruby"

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.4"
  spec.add_development_dependency "webmock", "~> 2.3"
  spec.add_development_dependency "rubocop", "~> 0.48"
  spec.add_development_dependency "bundler-audit", "~> 0.5"
  spec.add_development_dependency "simplecov", "~> 0.12"

  spec.add_runtime_dependency "rest-client", "~> 2.0"
end
