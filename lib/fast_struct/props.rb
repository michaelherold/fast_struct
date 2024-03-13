# typed: true
# frozen_string_literal: true

module FastStruct
  class Props
    def initialize
      @props = {}
    end

    def call(struct_class, &block)
      instance_exec(&block)
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

    def each_value(&block)
      @props.each_value { |value| yield value }
    end

    def empty?
      @props.empty?
    end

    private

    def define_attributes(struct)
      attr_methods = @props.each_value.map(&:definition).join("\n")

      struct.class_eval attr_methods
    end

    def define_initializer(struct)
      parameters = @props.each_value.map { |prop| "#{prop.name}: #{prop.default}" }.join(", ")
      setters = @props.each_value.map { |prop| "@#{prop.name} = #{prop.name}" }.join("\n")

      struct.class_eval <<~RUBY, __FILE__, __LINE__ + 1
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
