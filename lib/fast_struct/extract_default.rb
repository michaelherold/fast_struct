# typed: false
# frozen_string_literal: true

require "prism"

module FastStruct
  class ExtractDefault
    def self.call(name:, within:)
      return unless within

      define_node = DefineExtractor.extract(within:) or return
      property_node = PropertyExtractor.extract(define_node:, name:) or return

      DefaultExtractor.extract(property_node)
    end

    private

    class DefineExtractor < Prism::Visitor
      class CacheEntry
        def initialize(node)
          @node = node
        end

        attr_reader :node

        def ==(other)
          other.instance_of?(CacheEntry) &&
            node == other.node
        end
        alias_method :eql?, :==

        def hash
          [self.class, @node].hash
        end

        def cover?(line)
          location = @node.location

          location.start_line <= line &&
            location.end_line >= line
        end
      end

      def self.cache
        @cache ||= Hash.new { |h, k| h[k] = Set.new }
      end

      def self.extract(within:)
        file = within.absolute_path or return
        line = within.lineno or return

        if (cache_entry = cache[file].find { |entry| entry.cover?(line) })
          cache_entry.node
        else
          tree = Prism.parse(File.read(file)).value
          new(file, line).extract(tree)
        end
      end

      def initialize(file, line)
        super()
        @file = file
        @line = line
        @define_node = nil
      end

      def extract(tree)
        visit tree

        @define_node
      end

      def visit_call_node(node)
        return super unless node.name == :define

        self.class.cache[@file].add(CacheEntry.new(node))

        location = node.location
        @define_node = node if location.start_line <= @line && location.end_line >= @line

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
