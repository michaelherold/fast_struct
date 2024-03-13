# typed: true
# frozen_string_literal: true

unless ENV["NO_COVERAGE"]
  require "simplecov"

  SimpleCov.start do
    add_filter "/test/"
    enable_coverage :branch
    enable_coverage_for_eval
    primary_coverage :branch
  end

  SimpleCov.command_name "test:unit"
end

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require "minitest/autorun"
require "minitest/reporters"

require "fast_struct"

Minitest::Reporters.use! [
  Minitest::Reporters::DefaultReporter.new(
    color: true
  )
]
