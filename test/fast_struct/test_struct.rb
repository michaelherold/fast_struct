# frozen_string_literal: true

require "test_helper"

module FastStruct
  class TestStruct < Minitest::Test
    def test_default
      my_struct = Class.new(FastStruct::Struct) do
        define do
          const :x, Numeric, default: -> { 0 }
          prop :y, Numeric, default: -> { 1 }
          const :z, Numeric, default: proc { 2 }
        end
      end

      assert_equal 0, my_struct.new.x
      assert_equal 1, my_struct.new.y
      assert_equal 2, my_struct.new.z
    end

    def test_no_default_requires_an_argument
      my_struct = Class.new(FastStruct::Struct) do
        define do
          const :x, Numeric
        end
      end

      assert_raises(ArgumentError) { my_struct.new }
    end

    def test_on_a_multiline_default
      struct = Class.new(FastStruct::Struct) do
        define do
          # standard:disable Layout/EmptyLinesAroundBlockBody
          const(:x, Numeric, default: lambda do

            0

          end)
          # standard:enable Layout/EmptyLinesAroundBlockBody
        end
      end

      assert_equal 0, struct.new.x
    end

    def test_struct_within_namespace
      struct = Class.new(Struct) do
        define do
          const :x, Numeric, default: -> { 0 }
        end
      end

      assert_equal 0, struct.new.x
    end

    def test_struct_with_other_call_nodes
      struct = Class.new(FastStruct::Struct) do
        define do
          const :x, Numeric, default: -> { 0 }
        end
      end

      assert_equal 0, struct.new.x
    end

    def test_raising_on_defaulting_to_a_method_object
      assert_raises(FastStruct::FailedToExtractDefaultError) do
        struct = Class.new(FastStruct::Struct) do
          define do
            const :x, Numeric, default: TestStruct.method(:a_spurious_method)
          end
        end

        struct
      end
    end

    def self.a_spurious_method = nil

    private

    class ASpuriousClassNode
      AnotherSpuriousClassNode = Class.new

      def self.foo
        new
      end
    end

    def a_spurious_call_node
      Hash.new # standard:disable Style/EmptyLiteral
    end
  end
end
