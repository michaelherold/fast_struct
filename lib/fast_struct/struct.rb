# frozen_string_literal: true

module FastStruct
  class Struct
    def self.define(&block)
      if self == FastStruct::Struct
        raise RequiresSubclassError, "`define' must be called on a subclass of #{self}"
      end

      @props.instance_exec(&block)
      @props.define_initializer(self)
      @props.define_attributes(self)
    end

    def self.inherited(child)
      child.instance_variable_set(:@props, Props.new)
    end

    class << self
      attr_reader :props
    end

    class Props
      def initialize
        @props = {}
      end

      def const(name, type, default: Undefined)
        default_definition = extract_default(name, default)

        @props[name] = Const.new(name, type, default: default_definition)
      end

      def prop(name, type, default: Undefined)
        default_definition = extract_default(name, default)

        @props[name] = Prop.new(name, type, default: default_definition)
      end

      def each_value
        return to_enum(__callee__) unless block_given?

        @props.each_value { |value| yield value }
      end

      def define_attributes(struct)
        attr_methods = each_value.map(&:definition).join("\n")

        struct.class_eval attr_methods
      end

      def define_initializer(struct)
        parameters = each_value.map { |prop| "#{prop.name}: #{prop.default}" }.join(", ")
        setters = each_value.map { |prop| "@#{prop.name} = #{prop.name}" }.join("\n")

        struct.class_eval <<~RUBY, __FILE__, __LINE__ + 1
          def initialize(#{parameters})
            #{setters}
          end
        RUBY
      end

      private

      def extract_default(name, default)
        return if default == Undefined

        ExtractDefault.call(name: name, from: default).tap do |result|
          raise FailedToExtractDefaultError unless result
        end
      end

      class Const
        def initialize(name, type, default:)
          @name = name
          @type = type
          @default = default
        end

        attr_reader :default
        attr_reader :name
        attr_reader :type

        def definition
          "attr_reader :#{@name}"
        end
      end

      class Prop
        def initialize(name, type, default:)
          @name = name
          @type = type
          @default = default
        end

        attr_reader :default
        attr_reader :name
        attr_reader :type

        def definition
          "attr_accessor :#{@name}"
        end
      end
    end
  end
end
