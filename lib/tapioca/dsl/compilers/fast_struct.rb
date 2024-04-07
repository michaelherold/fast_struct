# typed: strict
# frozen_string_literal: true

require "fast_struct"
require "tapioca"

module Tapioca
  module Dsl
    module Compilers
      # `Tapioca::Dsl::Compilers::SmartProperties` generates RBI files for classes that include
      # [`SmartProperties`](https://github.com/t6d/smart_properties).
      #
      # For example, with the following class that includes `SmartProperties`:
      #
      # ~~~rb
      # # post.rb
      # class Post < FastStruct::Struct
      #   define do
      #     const :title, T.nilable(::String)
      #     prop :description, String
      #     prop :published, T.nilable(T::Boolean)
      #     prop :enabled, T.nilable(T::Boolean)
      #   end
      # end
      # ~~~
      #
      # this compiler will produce the RBI file `post.rbi` with the following content:
      #
      # ~~~rbi
      # # post.rbi
      # # typed: true
      # class Post
      #   sig { returns(T.nilable(::String)) }
      #   def title; end
      #
      #   sig { returns(::String) }
      #   def description; end
      #
      #   sig { params(description: ::String).returns(::String) }
      #   def description=(description); end
      #
      #   sig { returns(T.nilable(T::Boolean)) }
      #   def published?; end
      #
      #   sig { params(published: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
      #   def published=(published); end
      #
      #   sig { returns(T.nilable(T::Boolean)) }
      #   def enabled; end
      #
      #   sig { params(enabled: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
      #   def enabled=(enabled); end
      # end
      # ~~~
      class FastStruct < Compiler
        extend T::Sig

        ConstantType = type_member { {fixed: T.class_of(::FastStruct::Struct)} }

        sig { override.returns(T::Enumerable[Module]) }
        def self.gather_constants
          all_classes
            .select { |klass| name_of(klass) && klass < ::FastStruct::Struct }
        end

        sig { override.void }
        def decorate
          props = constant.props
          return if props.empty?

          root.create_path(constant) do |path|
            fast_struct_methods_names = "FastStructGeneratedMethods"

            path.create_module(fast_struct_methods_names) do |mod|
              props.each_value do |property|
                generate_methods_for_property(mod, property)
              end
            end

            path.create_include(fast_struct_methods_names)
          end
        end

        private

        sig do
          params(
            mod: RBI::Scope,
            property: ::FastStruct::Property
          ).void
        end
        def generate_methods_for_property(mod, property)
          type = property.type
          type_name = type_name_for(type)
          name = property.name.to_s

          if property.writeable?
            mod.create_method(
              "#{name}=",
              parameters: [create_param(name, type: type_name)],
              return_type: type_name
            )
          end

          mod.create_method(name, return_type: type_name)
        end

        def type_name_for(type)
          return type.to_s if type.is_a?(T::Types::Base)
          return ::FastStruct::DryTypesCompiler.call(type) if defined?(::Dry::Types::Type) && type.is_a?(::Dry::Types::Type)

          qualified_name_of(type)
        end
      end
    end
  end
end
