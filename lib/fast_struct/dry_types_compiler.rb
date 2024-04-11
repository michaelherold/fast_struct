# typed: false
# frozen_string_literal: true

require "singleton"

module FastStruct
  # This class is based on the compiler from the tapioca-compilers-dry_struct gem
  # as seen [here][1]. The gem is licensed under the MIT license and is distributed
  # under the same terms.
  #
  # [1]: https://github.com/YukiJikumaru/tapioca-compilers-dry_struct/blob/79392a187b287270fba97509eb2cbc1112e22623/lib/tapioca/dsl/compilers/dry_struct.rb#L45-L207
  class DryTypesCompiler
    class Map
      def initialize(key, value)
        @key = key
        @value = value
      end

      attr_reader :key
      attr_reader :value
    end

    class Schema
      def initialize(attribute_info)
        @attribute_info = attribute_info
      end
    end

    class Sum
      include Enumerable

      def initialize
        @nilable = false
        @types = ::Set.new
      end

      attr_reader :types

      def <<(arg)
        if arg == NilClass
          @nilable = true and return
        end

        case arg
        when Sum then @types.merge(arg.types)
        else @types << arg
        end
      end

      def each(&)
        @types.each(&)
      end

      def nilable?
        @nilable
      end

      def size
        @types.size
      end
    end

    class Untyped
    end

    def self.call(type)
      new.compile(type.to_ast)
    end

    def compile(node)
      klass = visit(node)

      to_sorbet_type(klass)
    end

    private

    def to_sorbet_type(klass)
      if klass.is_a?(Array)
        "::T::Array[#{to_sorbet_type(klass.first)}]"
      elsif klass.is_a?(Map)
        "::T::Hash[::#{klass.key}, ::#{klass.value}]"
      elsif klass.is_a?(Sum)
        sum_to_sorbet_type(klass)
      elsif klass.is_a?(Untyped)
        "::T.untyped"
      elsif klass.is_a?(Schema)
        "::T::Hash[::Symbol, ::T.untyped]"
      elsif klass == Hash
        "::T::Hash[::T.untyped, ::T.untyped]"
      elsif klass == NilClass
        "::NilClass"
      elsif klass == FalseClass || klass == TrueClass
        "::T::Boolean"
      elsif klass == Range
        "::T::Range[::T.untyped]"
      elsif klass == Set
        "::T::Set[::T.untyped]"
      else
        "::#{klass.name}"
      end
    end

    def sum_to_sorbet_type(sum)
      base =
        if sum.any? { |type| type.is_a?(Untyped) }
          "::T.untyped"
        elsif sum.size == 1
          to_sorbet_type(sum.first)
        elsif (sum.types - [FalseClass, TrueClass]).empty?
          "::T::Boolean"
        else
          "::T.any(#{sum.map { |type| to_sorbet_type(type) }.join(", ")})"
        end

      if sum.nilable?
        "::T.nilable(#{base})"
      else
        base
      end
    end

    def visit(node)
      type, rest = node

      __send__(:"visit_#{type}", rest)
    end

    def visit_and(node)
    end

    def visit_any(node)
      Untyped.new
    end

    def visit_array(node)
      [visit(node.first)]
    end

    def visit_constrained(node)
      types = node.filter_map { |r| visit(r) }

      if types.size == 1
        types.first
      else
        types
      end
    end

    def visit_constructor(node)
      klass, _ = node

      visit(klass)
    end

    def visit_enum(node)
      visit(node.dig(0, 1, 0))
    end

    def visit_hash(node)
      ::Hash
    end

    def visit_key(node)
      name, required, rest = node

      {name:, required:, type: visit(rest)}
    end

    def visit_map(node)
      key, value = node

      Map.new(visit(key), visit(value))
    end

    def visit_nominal(node)
      node.first
    end

    def visit_predicate(node)
    end

    def visit_schema(node)
      Schema.new(node.first.map { |n| visit(n) })
    end

    def visit_struct(node)
      node.first
    end

    def visit_sum(node)
      Sum.new.tap do |type|
        node.each do |n|
          next if n.is_a?(::Hash)

          type << visit(n)
        end
      end
    end
  end
end
