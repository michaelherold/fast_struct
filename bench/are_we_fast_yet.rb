#!/usr/bin/env ruby
# typed: false
# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path(File.join(__dir__, "../lib"))

def has_data?
  Gem::Version.new(RUBY_VERSION) >= Gem::Version.new("3.2.0")
end

require "benchmark/ips"
require "dry-initializer"
require "dry/struct"
require "fast_struct"
require "sorbet-runtime"

module Types
  include Dry.Types()

  Numeric = Types::Instance(Numeric)
  Default0 = Numeric.default(0)
  Default1 = Numeric.default(1)
  Default2 = Numeric.default(2)
end


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

class DryStruct < Dry::Struct
  attribute :x, Types::Numeric
  attribute :y, Types::Numeric
  attribute :z, Types::Numeric
end

class DryInit
  extend Dry::Initializer

  option :x, type: Types::Numeric
  option :y, type: Types::Numeric
  option :z, type: Types::Numeric
end

class Sorbet < T::Struct
  const :x, Numeric
  const :y, Numeric
  prop :z, Numeric
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

  class DryStruct < Dry::Struct
    attribute :x, Types::Default0
    attribute :y, Types::Default1
    attribute :z, Types::Default2
  end

  class DryInit
    extend Dry::Initializer

    option :x, type: Types::Numeric, default: -> { 0 }
    option :y, type: Types::Numeric, default: -> { 1 }
    option :z, type: Types::Numeric, default: -> { 2 }
  end

  class Sorbet < T::Struct
    const :x, Numeric, default: 0
    const :y, Numeric, default: 1
    prop :z, Numeric, default: 2
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
  bench.report("Dry Struct") { DryStruct.new(x: 1, y: 2, z: 3).x }
  bench.report("Dry Initializer") { DryInit.new(x: 1, y: 2, z: 3).x }
  bench.report("T::Struct") { Sorbet.new(x: 1, y: 2, z: 3).x }

  bench.compare!
end

headline "Performing an operation, with defaults"

Benchmark.ips do |bench|
  bench.report("defaults FastStruct") { WithDefaults::Fast.new.x }
  bench.report("defaults Struct") { WithDefaults::StdLib.new.x }
  bench.report("defaults Data") { WithDefaults::AsData.new.x } if has_data?
  bench.report("defaults PORO") { WithDefaults::PORO.new.x }
  bench.report("defaults Dry Struct") { WithDefaults::DryStruct.new.x }
  bench.report("defaults Dry Initializer") { WithDefaults::DryInit.new(x: 1, y: 2, z: 3).x }
  bench.report("defaults T::Struct") { WithDefaults::Sorbet.new.x }

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

  bench.report("Dry Struct") do
    Class.new(Dry::Struct) do
      attribute :x, Types.Instance(Numeric)
      attribute :y, Types.Instance(Numeric)
      attribute :z, Types.Instance(Numeric)
    end
  end

  bench.report("Dry Initializer") do
    Class.new do
      extend Dry::Initializer

      option :x, type: Types.Instance(Numeric)
      option :y, type: Types.Instance(Numeric)
      option :z, type: Types.Instance(Numeric)
    end
  end

  bench.report("T::Struct") do
    Class.new(T::Struct) do
      const :x, Numeric
      const :y, Numeric
      prop :z, Numeric
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

  bench.report("Dry Struct") do
    Class.new(Dry::Struct) do
      attribute :x, Types.Instance(Numeric).default(0)
      attribute :y, Types.Instance(Numeric).default(1)
      attribute :z, Types.Instance(Numeric).default(2)
    end
  end

  bench.report("Dry Initializer") do
    Class.new do
      extend Dry::Initializer

      option :x, type: Types.Instance(Numeric), default: -> { 0 }
      option :y, type: Types.Instance(Numeric), default: -> { 1 }
      option :z, type: Types.Instance(Numeric), default: -> { 2 }
    end
  end

  bench.report("T::Struct") do
    Class.new(T::Struct) do
      const :x, Numeric, default: 0
      const :y, Numeric, default: 1
      prop :z, Numeric, default: 2
    end
  end

  bench.compare!
end
