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
      if FastStruct.dry_types_enabled? && @type.is_a?(Dry::Types::Type) # steep:ignore UnknownConstant
        declaration = "self.class.props.at(:#{@name}).type.call(#{@name})"
        type = DryTypesCompiler.call(@type)
      else
        declaration = @name.to_s
        type = @type.to_s
      end

      if FastStruct.sorbet_sigs_enabled?
        "@#{@name} = T.let(#{declaration}, #{type})"
      elsif FastStruct.dry_types_enabled? && @type.is_a?(Dry::Types::Type) # steep:ignore UnknownConstant
        "@#{@name} = #{declaration}"
      else
        "@#{@name} = #{declaration}"
      end
    end

    def to_sig_param
      if defined?(Dry::Types::Type) && @type.is_a?(Dry::Types::Type) # steep:ignore UnknownConstant
        "#{@name}: #{DryTypesCompiler.call(@type)}"
      else
        "#{@name}: #{@type}"
      end
    end
  end
end
