# frozen_string_literal: true

module FastStruct
  class Const
    def initialize(name, type, default:)
      @name = name
      @type = type
      @default = default
    end

    attr_reader :default
    attr_reader :name
    attr_reader :type

    def definition
      "attr_reader :#{@name}"
    end
  end
end
