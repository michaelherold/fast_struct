#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path(File.join(__dir__, "../lib"))

def has_data?
  Gem::Version.new(RUBY_VERSION) >= Gem::Version.new("3.2.0")
end

require "benchmark/ips"
require "fast_struct"

class Fast < FastStruct::Struct
  define do
    const :x, Numeric
    const :y, Numeric
    prop :z, Numeric
  end
end

StdLib = Struct.new(:x, :y, :z, keyword_init: true) do
  undef_method :x=
  undef_method :y=
end

AsData = Data.define(:x, :y, :z) if has_data?

class PORO
  def initialize(x:, y:, z:)
    @x = x
    @y = y
    @z = z
  end

  attr_reader :x, :y
  attr_accessor :z
end

module WithDefaults
  class Fast < FastStruct::Struct
    define do
      const :x, Numeric, default: -> { 0 }
      const :y, Numeric, default: -> { 1 }
      prop :z, Numeric, default: -> { 2 }
    end
  end

  StdLib = Struct.new(:x, :y, :z, keyword_init: true) do
    undef_method :x=
    undef_method :y=

    def initialize(x: 0, y: 1, z: 2)
      super
    end
  end

  if has_data?
    AsData = Data.define(:x, :y, :z) do
      def initialize(x: 0, y: 1, z: 2)
        super
      end
    end
  end

  class PORO
    def initialize(x: 0, y: 1, z: 2)
      @x = x
      @y = y
      @z = z
    end

    attr_reader :x, :y
    attr_accessor :z
  end
end

def headline(message)
  puts <<~MSG
    #{message}
    =================================================

  MSG
end

headline "Performing an operation, no defaults"

Benchmark.ips do |bench|
  bench.report("FastStruct") { Fast.new(x: 1, y: 2, z: 3).x }
  bench.report("Struct") { StdLib.new(x: 1, y: 2, z: 3).x }
  bench.report("Data") { AsData.new(x: 1, y: 2, z: 3).x } if has_data?
  bench.report("PORO") { PORO.new(x: 1, y: 2, z: 3).x }

  bench.compare!
end

headline "Performing an operation, with defaults"

Benchmark.ips do |bench|
  bench.report("defaults FastStruct") { WithDefaults::Fast.new.x }
  bench.report("defaults Struct") { WithDefaults::StdLib.new.x }
  bench.report("defaults Data") { WithDefaults::AsData.new.x } if has_data?
  bench.report("defaults PORO") { WithDefaults::PORO.new.x }

  bench.compare!
end

headline "Defining a class, no defaults"

Benchmark.ips do |bench|
  bench.report("FastStruct") do
    Class.new(FastStruct::Struct) do
      define do
        const :x, Numeric
        const :y, Numeric
        prop :z, Numeric
      end
    end
  end

  bench.report("Struct") do
    Struct.new(:x, :y, :z, keyword_init: true) do
      undef_method :x=
      undef_method :y=
    end
  end

  if has_data?
    bench.report("Data") do
      Data.define(:x, :y, :z)
    end
  end

  bench.report("PORO") do
    Class.new do
      def initialize(x:, y:, z:)
        @x = x
        @y = y
        @z = z
      end

      attr_reader :x, :y
      attr_accessor :z
    end
  end

  bench.compare!
end

headline "Defining a class, with defaults"

Benchmark.ips do |bench|
  bench.report("FastStruct") do
    Class.new(FastStruct::Struct) do
      define do
        const :x, Numeric, default: -> { 9 }
        const :y, Numeric, default: -> { 8 }
        prop :z, Numeric, default: -> { 7 }
      end
    end
  end

  bench.report("Struct") do
    Struct.new(:x, :y, :z, keyword_init: true) do
      def initialize(x: 9, y: 8, z: 7)
        super
      end

      undef_method :x=
      undef_method :y=
    end
  end

  if has_data?
    bench.report("Data") do
      Data.define(:x, :y, :z) do
        def initialize(x: 9, y: 8, z: 7)
          super
        end
      end
    end
  end

  bench.report("PORO") do
    Class.new do
      def initialize(x: 9, y: 8, z: 7)
        @x = x
        @y = y
        @z = z
      end

      attr_reader :x, :y
      attr_accessor :z
    end
  end

  bench.compare!
end
