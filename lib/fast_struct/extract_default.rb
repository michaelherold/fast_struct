# frozen_string_literal: true

require "prism"

module FastStruct
  class ExtractDefault
    def self.call(name:, from:)
      file, line = from.source_location
      tree = Prism.parse(File.read(file)).value

      struct_node = StructExtractor.extract(line:, tree:) or return
      define_node = DefineExtractor.extract(struct_node:) or return
      property_node = PropertyExtractor.extract(define_node:, name:) or return

      DefaultExtractor.extract(property_node)
    end

    private

    class StructExtractor < Prism::Visitor
      def self.extract(line:, tree:)
        new(line:).extract(tree)
      end

      def initialize(line:)
        super()
        @line = line
        @struct_node = nil
        @module_path = []
      end

      def extract(tree)
        visit tree

        @struct_node
      end

      def visit_module_node(node)
        @module_path.push node
        super
        @module_path.pop
      end

      def visit_call_node(node)
        return super unless node.name == :new
        return super unless (receiver = node.receiver)
        return super unless receiver.is_a?(Prism::ConstantReadNode)
        return super unless receiver.name == :Class

        superclass = node.arguments&.arguments&.first or return super
        visit_struct_node(node, superclass:) or return super
      end

      def visit_class_node(node)
        superclass = node.superclass or return super
        visit_struct_node(node, superclass:) or return super
      end

      def visit_struct_node(node, superclass:)
        if struct_superclass?(superclass, parent: node)
          @struct_node = node
        end
      end

      private

      def struct_superclass?(superclass, parent:)
        location = parent.location
        span = location.start_line..location.end_line

        span.cover?(@line) &&
          (direct_superclass?(superclass) || superclass_in_namespace?(superclass))
      end

      def direct_superclass?(superclass)
        superclass.is_a?(Prism::ConstantPathNode) &&
          superclass.child.name == :Struct &&
          superclass.parent.name == :FastStruct
      end

      def superclass_in_namespace?(superclass)
        name_of_superclass(superclass) == :Struct &&
          @module_path.any? { |mod| mod.constant_path.name == :FastStruct }
      end

      def name_of_superclass(superclass)
        if superclass.is_a?(Prism::ConstantPathNode)
          superclass.child.name
        else
          superclass.name
        end
      end
    end

    class DefineExtractor < Prism::Visitor
      def self.extract(struct_node:)
        new.extract(struct_node)
      end

      def initialize
        super()
        @define_node = nil
      end

      def extract(struct_node)
        visit struct_node

        @define_node
      end

      def visit_call_node(node)
        if node.name == :define
          @define_node = node
          return
        end

        super
      end
    end

    class PropertyExtractor < Prism::Visitor
      def self.extract(define_node:, name:)
        new(name).extract(define_node)
      end

      def initialize(name)
        super()
        @name = name
        @property_node = nil
      end

      def extract(define_node)
        visit define_node.block

        @property_node
      end

      def visit_call_node(node)
        method = node.name

        if (method == :const || method == :prop) &&
            node.arguments.arguments.first.slice == @name.inspect

          @property_node = node
          return
        end

        super
      end
    end

    class DefaultExtractor < Prism::Visitor
      def self.extract(property_node)
        new.extract property_node
      end

      def initialize
        super()
        @default = nil
      end

      def extract(property_node)
        visit property_node

        @default
      end

      def visit_assoc_node(node)
        case (value = node.value)
        when Prism::CallNode
          if value.name == :lambda || value.name == :proc || proc_new?(value)
            @default = value.block.body.slice
          end
        when Prism::LambdaNode
          @default = value.body.slice
        end

        super
      end

      private

      def proc_new?(node)
        return false unless (receiver = node.receiver) && receiver.is_a?(Prism::ConstantReadNode)

        node.name == :new && receiver.name == :Proc
      end
    end

    private_constant :StructExtractor, :DefineExtractor, :PropertyExtractor, :DefaultExtractor
  end
end
