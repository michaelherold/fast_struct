# frozen_string_literal: true

require_relative "fast_struct/struct"
require_relative "fast_struct/version"

module FastStruct
  Error = Class.new(StandardError)
  RequiresSubclassError = Class.new(Error)
end
