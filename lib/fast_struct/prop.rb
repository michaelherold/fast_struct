# typed: true
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
      if FastStruct.sorbet_sigs_enabled?
        <<~RUBY
          sig { params(value: #{@type}).returns(#{@type}) }
          attr_accessor :#{@name}
        RUBY
      else
        "attr_accessor :#{@name}"
      end
    end

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

    def writeable?
      true
    end
  end
end
