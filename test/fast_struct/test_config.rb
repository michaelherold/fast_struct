# typed: ignore
# frozen_string_literal: true

require "test_helper"

module FastStruct
  class TestConfig < Minitest::Test
    module Types
      include Dry.Types()
    end

    def test_enabling_sorbet_sigs
      struct = with_overridden_config(sorbet_sigs_enabled: true) do
        Class.new(FastStruct::Struct) do
          define do
            const :x, Integer, default: -> { 1 }
            prop :y, Integer, default: -> { 1 }
          end
        end
      end

      assert_raises(TypeError) do
        struct.new(x: "1")
      end

      assert_raises(TypeError) do
        struct.new(y: "1")
      end

      struct.new(x: 2, y: 2)
    end

    def test_enabling_sorbet_sigs_without_properties
      struct = with_overridden_config(sorbet_sigs_enabled: true) do
        Class.new(FastStruct::Struct) do
          define do
          end
        end
      end

      struct.new
    end

    def test_enabling_dry_types
      struct = with_overridden_config(dry_types_enabled: true) do
        Class.new(FastStruct::Struct) do
          define do
            const :x, Types::Coercible::Integer.constrained(gt: 0, lt: 10)
            prop :y, Types::Coercible::Integer.constrained(gt: 0, lt: 10), default: -> { 2 }
          end
        end
      end

      assert_raises(Dry::Types::ConstraintError) do
        struct.new(x: 12)
      end

      assert_raises(Dry::Types::ConstraintError) do
        struct.new(x: 2, y: 12)
      end

      assert_equal 4, struct.new(x: 4).x
      assert_equal 4, struct.new(x: "4").x
    end

    def test_enabling_sorbet_and_dry_types_at_once
      struct = with_overridden_config(dry_types_enabled: true, sorbet_sigs_enabled: true) do
        Class.new(FastStruct::Struct) do
          define do
            const :x, Types::Coercible::Integer.constrained(gt: 0, lt: 10)
            prop :y, Integer, default: -> { 2 }
          end
        end
      end

      assert_raises(Dry::Types::ConstraintError) do
        struct.new(x: 12)
      end
    end

    def test_all_kinds_of_dry_types
      dry_struct = Class.new(Dry::Struct) do
        attribute :a, Types::String
      end
      struct = with_overridden_config(dry_types_enabled: true) do
        Class.new(FastStruct::Struct) do
          define do
            const :a, Types::Nil | Types::String
            const :b, Types::Hash.schema(name: Types::String)
            const :c, Types::Array.of(Types::String)
            const :d, Types::Integer.constrained(gt: 1, lt: 10)
            const :e, Types.Constructor(String)
            const :f, Types::String.enum("hi", "bye")
            const :g, Types::Hash
            const :h, Types::Hash.map(Types::Integer, Types::String)
            const :i, Types::True | Types::False | Types::Nil
            const :j, Types::Any
            const :k, Types::Nil
            const :l, Types.Instance(Range)
            const :m, Types.Instance(Set)
            const :n, Types.Instance(TrueClass)
            const :o, Types::Any | Types::Nil
            const :p, Types::Integer | Types::String
            const :q, dry_struct
          end
        end
      end

      struct.new(
        a: nil,
        b: {name: "hi"},
        c: ["hi"],
        d: 2,
        e: "hi",
        f: "hi",
        g: {name: "hi"},
        h: {1 => "hi"},
        i: true,
        j: "hi",
        k: nil,
        l: (1..),
        m: Set["hi"],
        n: true,
        o: "hi",
        p: "hi",
        q: dry_struct.new(a: "hi")
      )
    end

    private

    def with_overridden_config(dry_types_enabled: false, sorbet_sigs_enabled: false)
      original_config = FastStruct.config
      FastStruct.config = Config.new
      FastStruct.configure do |config|
        config.dry_types_enabled = dry_types_enabled
        config.sorbet_sigs_enabled = sorbet_sigs_enabled
      end
      yield
    ensure
      FastStruct.config = original_config
    end
  end
end
