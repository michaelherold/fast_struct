# typed: true
# frozen_string_literal: true

require_relative "fast_struct/struct"
require_relative "fast_struct/version"

module FastStruct
  Error = Class.new(StandardError)
  FailedToExtractDefaultError = Class.new(Error)
  RequiresSubclassError = Class.new(Error)

  autoload :Config, "fast_struct/config"
  autoload :Const, "fast_struct/const"
  autoload :DryTypesCompiler, "fast_struct/dry_types_compiler"
  autoload :ExtractDefault, "fast_struct/extract_default"
  autoload :Prop, "fast_struct/prop"
  autoload :Property, "fast_struct/property"
  autoload :Props, "fast_struct/props"

  @config = Config.new

  def self.configure(&block)
    yield config
  end

  def self.dry_types_enabled?
    defined?(Dry::Types) && config.dry_types_enabled
  end

  def self.sorbet_sigs_enabled?
    defined?(T::Sig) && config.sorbet_sigs_enabled
  end

  class << self
    attr_accessor :config
  end
end
