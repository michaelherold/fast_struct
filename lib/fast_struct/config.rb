# typed: true
# frozen_string_literal: true

module FastStruct
  class Config
    def initialize(dry_types_enabled: false, sorbet_sigs_enabled: false)
      @dry_types_enabled = dry_types_enabled
      @sorbet_sigs_enabled = sorbet_sigs_enabled
    end

    attr_accessor :dry_types_enabled
    attr_accessor :sorbet_sigs_enabled
  end
end
