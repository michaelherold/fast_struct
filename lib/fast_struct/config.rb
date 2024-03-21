# typed: true
# frozen_string_literal: true

module FastStruct
  class Config
    def initialize(sorbet_sigs_enabled: false)
      @sorbet_sigs_enabled = sorbet_sigs_enabled
    end

    attr_accessor :sorbet_sigs_enabled
  end
end
