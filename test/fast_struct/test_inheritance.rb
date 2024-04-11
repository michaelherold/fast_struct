# typed: false
# frozen_string_literal: true

require "test_helper"

module FastStruct
  class TestInheritance < Minitest::Test
    def test_inheritance_allows_extending_props
      first = Class.new(FastStruct::Struct) do
        define do
          const :x, Numeric, default: -> { 0 }
          const :y, Numeric, default: -> { 0 }
        end
      end

      second = Class.new(first) do
        define do
          const :z, Numeric, default: -> { 0 }
        end
      end

      assert_equal 1, first.new(x: 0, y: 1).y
      assert_equal 2, second.new(x: 0, y: 1, z: 2).z
      assert_equal 0, first.new.x
      assert_equal 0, second.new.x

      assert_raises(ArgumentError) { first.new(x: 0, y: 1, z: 2) }
    end
  end
end
