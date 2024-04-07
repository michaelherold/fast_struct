# typed: true
# frozen_string_literal: true

module FastStruct
  class Const < Property
    def definition
      if FastStruct.sorbet_sigs_enabled?
        type =
          if FastStruct.dry_types_enabled? && @type.is_a?(Dry::Types::Type) # steep:ignore UnknownConstant
            DryTypesCompiler.call(@type)
          else
            @type
          end

        <<~RUBY
          sig { returns(#{type}) }
          attr_reader :#{@name}
        RUBY
      else
        "attr_reader :#{@name}"
      end
    end

    def writeable?
      false
    end
  end
end
