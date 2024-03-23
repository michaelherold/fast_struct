# typed: true
# frozen_string_literal: true

module FastStruct
  class Const < Property
    def definition
      if FastStruct.sorbet_sigs_enabled?
        <<~RUBY
          sig { returns(#{@type}) }
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
