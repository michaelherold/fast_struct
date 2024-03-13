# typed: true

module SimpleCov
  class << self
    sig { params(profile: T.nilable(T.any(::String, ::Symbol)), block: T.nilable(T.proc.bind(::SimpleCov::Configuration).void)).void }
    def start(profile = nil, &block); end
  end
end
