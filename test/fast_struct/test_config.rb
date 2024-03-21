# typed: true
# frozen_string_literal: true

require "test_helper"

module FastStruct
  class TestConfig < Minitest::Test
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

    private

    def with_overridden_config(sorbet_sigs_enabled: false)
      original_config = FastStruct.config
      FastStruct.config = Config.new
      FastStruct.configure do |config|
        config.sorbet_sigs_enabled = sorbet_sigs_enabled
      end
      yield
    ensure
      FastStruct.config = original_config
    end
  end
end
