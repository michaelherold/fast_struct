# typed: strict
# frozen_string_literal: true

module FastStruct
  class Property
    def initialize(name, type, default:)
      @name = name
      @type = type
      @default = default
    end

    attr_reader :default
    attr_reader :name
    attr_reader :type

    def to_initializer
      "#{@name}: #{@default}"
    end

    def to_setter
      if FastStruct.sorbet_sigs_enabled?
        "@#{@name} = T.let(#{@name}, #{@type})"
      else
        "@#{@name} = #{@name}"
      end
    end

    def to_sig_param
      "#{@name}: #{@type}"
    end
  end
end
