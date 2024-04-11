# typed: true

class FastStruct::Const < FastStruct::Property
  sig { override.returns(::String) }
  def definition; end

  sig { override.returns(T::Boolean) }
  def writeable?; end
end

class FastStruct::DryTypesCompiler
  class << self
    sig { params(type: ::Dry::Types::Type).returns(String) }
    def call(type); end
  end
end

class FastStruct::ExtractDefault
  class << self
    sig { params(name: Symbol, from: Proc).returns(T.nilable(String)) }
    def call(name:, from:); end
  end
end

class FastStruct::Prop < FastStruct::Property
  sig { override.returns(::String) }
  def definition; end

  sig { override.returns(T::Boolean) }
  def writeable?; end
end

class FastStruct::Property
  abstract!

  sig { params(name: ::Symbol, type: ::FastStruct::Type, default: T.nilable(::String)).void }
  def initialize(name, type, default:)
    @name = T.let(name, ::Symbol)
    @type = T.let(type, T.any(::T::Types::Base, ::Module))
    @default = T.let(default, T.nilable(String))
  end

  sig { returns(T.nilable(::String)) }
  def default; end

  sig { abstract.returns(::String) }
  def definition; end

  sig { returns(::Symbol) }
  def name; end

  sig { returns(::String) }
  def to_initializer; end

  sig { returns(::String) }
  def to_setter; end

  sig { returns(::String) }
  def to_sig_param; end

  sig { returns(::FastStruct::Type) }
  def type; end

  sig { abstract.returns(T::Boolean) }
  def writeable?; end
end

class FastStruct::Props
  sig { void }
  def initialize
    @props = T.let({}, T::Hash[::Symbol, ::FastStruct::Property])
  end

  sig { params(struct_class: T::Class[::FastStruct::Struct], block: T.proc.bind(::FastStruct::Props).params(arg0: T::Class[::FastStruct::Props]).returns(T.anything)).void }
  def call(struct_class, &block); end

  sig { params(name: ::Symbol, type: ::FastStruct::Type, default: T.nilable(T.proc.returns(T.untyped))).void }
  def const(name, type, default: T.unsafe(nil)); end

  sig { params(block: T.proc.params(arg0: ::FastStruct::Property).returns(::BasicObject)).returns(T::Hash[::Symbol, ::FastStruct::Property]) }
  def each_value(&block); end

  sig { returns(T::Boolean) }
  def empty?; end

  sig { params(name: ::Symbol, type: ::FastStruct::Type, default: T.nilable(T.proc.returns(T.untyped))).void }
  def prop(name, type, default: T.unsafe(nil)); end

  private

  sig { params(struct: T::Class[::FastStruct::Struct]).void }
  def define_attributes(struct); end

  sig { params(struct: T::Class[::FastStruct::Struct]).void }
  def define_initializer(struct); end

  sig { params(name: ::Symbol, default: T.nilable(T.proc.returns(T.anything))).returns(T.nilable(::String)) }
  def extract_default(name, default); end
end

class FastStruct::Struct
  class << self
    sig { params(block: T.proc.bind(::FastStruct::Props).params(arg0: T::Class[::FastStruct::Props]).returns(T.anything)).void }
    def define(&block); end

    sig { params(child: T::Class[T.anything]).void }
    def inherited(child); end

    sig { returns(::FastStruct::Props) }
    def props; end
  end
end

FastStruct::Type = T.type_alias { T.any(T::Types::Base, ::Module) }
