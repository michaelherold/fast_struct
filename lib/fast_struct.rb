# frozen_string_literal: true

require_relative "fast_struct/struct"
require_relative "fast_struct/version"

module FastStruct
  Error = Class.new(StandardError)
  FailedToExtractDefaultError = Class.new(Error)
  RequiresSubclassError = Class.new(Error)

  Undefined = Object.new.freeze

  autoload :Const, "fast_struct/const"
  autoload :ExtractDefault, "fast_struct/extract_default"
  autoload :Prop, "fast_struct/prop"
  autoload :Props, "fast_struct/props"
end
