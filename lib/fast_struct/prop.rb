# frozen_string_literal: true

module FastStruct
  class Prop
    def initialize(name, type, default:)
      @name = name
      @type = type
      @default = default
    end

    attr_reader :default
    attr_reader :name
    attr_reader :type

    def definition
      "attr_accessor :#{@name}"
    end
  end
end
