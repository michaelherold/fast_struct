#!/usr/bin/env ruby
# typed: ignore
# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path(File.join(__dir__, "../lib"))

require "benchmark/ips"
require "fast_struct"

def headline(message)
  puts <<~MSG
    #{message}
    =================================================

  MSG
end

without_defaults = proc do
  Class.new(FastStruct::Struct) do
    define do
      const :x, Numeric
      const :y, Numeric
      prop :z, Numeric
    end
  end
end

with_defaults = proc do
  Class.new(FastStruct::Struct) do
    define do
      const :x, Numeric, default: -> { 0 }
      const :y, Numeric, default: -> { 0 }
      prop :z, Numeric, default: -> { 0 }
    end
  end
end

headline "Measuring performance without defaults"

Benchmark.ips do |bench|
  bench.report("before", &without_defaults)
  bench.report("after", &without_defaults)

  bench.compare!(order: :baseline)
  bench.hold!(File.join(__dir__, "../tmp/faster_results_without_defaults.jsonld"))
end

headline "Measuring performance with defaults"

Benchmark.ips do |bench|
  bench.report("before", &with_defaults)
  bench.report("after", &with_defaults)

  bench.compare!(order: :baseline)
  bench.hold!(File.join(__dir__, "../tmp/faster_results_with_defaults.jsonld"))
end
