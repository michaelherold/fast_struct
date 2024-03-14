# frozen_string_literal: true

require_relative "lib/fast_struct/version"

Gem::Specification.new do |spec|
  spec.name = "fast_struct"
  spec.version = FastStruct::VERSION
  spec.authors = ["Michael Herold"]
  spec.email = ["opensource@michaeljherold.com"]

  spec.summary = "Zero-cost structs that can be strongly typed by RBS or Sorbet"
  spec.description = spec.summary
  spec.homepage = "https://github.com/michaelherold/fast_struct"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.files = %w[CHANGELOG.md CONTRIBUTING.md LICENSE.md README.md UPGRADING.md]
  spec.files += %w[ksuid.gemspec]
  spec.files += Dir["lib/**/*.rb"]
  spec.files += Dir["rbi/**/*.rb"]
  spec.files += Dir["sig/**/*.rbs"]
  spec.require_paths = ["lib"]

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/tree/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.add_development_dependency "bundler", ">= 1.16"
end
