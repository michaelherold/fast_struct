# typed: false
# frozen_string_literal: true

require "test_helper"

class TestFastStruct < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::FastStruct::VERSION
  end

  def test_basics
    point = Class.new(FastStruct::Struct) do
      define do
        const :x, Numeric
        const :y, Numeric
        prop :z, Numeric
      end
    end

    instance = point.new(x: 0, y: 1, z: 1)

    assert_equal 0, instance.x
    assert_equal 1, instance.y
    assert_equal 1, instance.z

    instance.z = 2

    assert_equal 2, instance.z
  end

  def test_defining_within_the_parent_class
    assert_raises(FastStruct::RequiresSubclassError) do
      FastStruct::Struct.define do
        const :x, Numeric
      end
    end
  end
end
