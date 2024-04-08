# typed: true
# frozen_string_literal: true

module FastStruct
  class Struct
    def self.define(&block)
      if self == FastStruct::Struct
        raise RequiresSubclassError, "`define' must be called on a subclass of #{self}"
      end

      props.call(self, &block)
    end

    def self.inherited(child)
      super

      if instance_variable_defined?(:@props)
        child.instance_variable_set(:@props, @props.dup)
      else
        child.instance_variable_set(:@props, Props.new)
      end
    end

    class << self
      attr_reader :props
    end
  end
end
