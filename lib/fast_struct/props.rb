# typed: true
# frozen_string_literal: true

module FastStruct
  class Props
    def initialize
      @props = {}
    end

    def call(struct_class, &block)
      instance_exec(&block)
      add_sorbet_sig(struct_class)
      define_initializer(struct_class)
      define_attributes(struct_class)
    end

    def const(name, type, default: nil)
      default_definition = extract_default(name, default)

      @props[name] = Const.new(name, type, default: default_definition)
    end

    def prop(name, type, default: nil)
      default_definition = extract_default(name, default)

      @props[name] = Prop.new(name, type, default: default_definition)
    end

    def at(name)
      @props.fetch(name)
    end

    def each_value(&block)
      @props.each_value { |value| yield value }
    end

    def empty?
      @props.empty?
    end

    private

    def add_sorbet_sig(struct)
      return unless FastStruct.sorbet_sigs_enabled?

      struct.extend(T::Sig) # steep:ignore UnknownConstant
    end

    def define_attributes(struct)
      attr_methods = @props.each_value.map(&:definition).join("\n")

      struct.class_eval attr_methods
    end

    def define_initializer(struct)
      parameters = @props.each_value.map(&:to_initializer).join(", ")
      setters = @props.each_value.map(&:to_setter).join("\n")
      sigs =
        if FastStruct.sorbet_sigs_enabled?
          params =
            unless @props.empty?
              "params(#{@props.each_value.map(&:to_sig_param).join(", ")})"
            end

          "sig { #{[params, "void"].compact.join(".")} }"
        end

      struct.class_eval <<~RUBY, __FILE__, __LINE__ + 1
        #{sigs}
        def initialize(#{parameters})
          #{setters}
        end
      RUBY
    end

    def extract_default(name, default)
      return unless default

      ExtractDefault.call(name: name, from: default).tap do |result|
        raise FailedToExtractDefaultError unless result
      end
    end
  end
end
