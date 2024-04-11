# typed: false
# frozen_string_literal: true

require "prism"

module FastStruct
  class ExtractDefault
    def self.call(name:, within:)
      return unless within

      file = within.absolute_path or return
      line = within.lineno or return
      tree = Prism.parse(File.read(file)).value

      define_node = DefineExtractor.extract(line:, tree:) or return
      property_node = PropertyExtractor.extract(define_node:, name:) or return

      DefaultExtractor.extract(property_node)
    end

    private

    class DefineExtractor < Prism::Visitor
      def self.extract(line:, tree:)
        new(line).extract(tree)
      end

      def initialize(line)
        super()
        @line = line
        @define_node = nil
      end

      def extract(tree)
        visit tree

        @define_node
      end

      def visit_call_node(node)
        if node.name == :define && (loc = node.location).start_line <= @line && loc.end_line >= @line
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
            node.arguments&.arguments&.first&.slice == @name.inspect

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
          if (value.name == :lambda || value.name == :proc || proc_new?(value)) && (default = body_from_block(value))
            @default = default
          end
        when Prism::LambdaNode
          @default = value.body&.slice
        end

        super
      end

      private

      def body_from_block(node)
        return unless (blk = node.block) && blk.is_a?(Prism::BlockNode)

        blk.body&.slice
      end

      def proc_new?(node)
        return false unless (receiver = node.receiver) && receiver.is_a?(Prism::ConstantReadNode)

        node.name == :new && receiver.name == :Proc
      end
    end

    private_constant :DefineExtractor, :PropertyExtractor, :DefaultExtractor
  end
end
