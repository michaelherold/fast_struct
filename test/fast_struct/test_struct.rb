# frozen_string_literal: true

require "test_helper"

module FastStruct
  class TestStruct < Minitest::Test
    def test_default
      my_struct = Class.new(FastStruct::Struct) do
        define do
          const :x, Numeric, default: -> { 0 }
          prop :y, Numeric, default: -> { 1 }
        end
      end

      assert_equal 0, my_struct.new.x
      assert_equal 1, my_struct.new.y
    end

    def test_no_default_requires_an_argument
      my_struct = Class.new(FastStruct::Struct) do
        define do
          const :x, Numeric
        end
      end

      assert_raises(ArgumentError) { my_struct.new }
    end
  end
end
