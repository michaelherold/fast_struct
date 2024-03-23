# typed: true
# frozen_string_literal: true

module FastStruct
  class Prop < Property
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

    def writeable?
      true
    end
  end
end
