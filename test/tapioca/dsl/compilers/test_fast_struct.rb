# typed: false
# frozen_string_literal: true

require "test_helper"

require "tapioca/internal"
require "tapioca/dsl/compilers/fast_struct"
require "tapioca/helpers/test/dsl_compiler"

module Tapioca
  module Dsl
    module Compilers
      class TestFastStruct < Minitest::Test
        include Tapioca::Helpers::Test::DslCompiler

        def setup
          use_dsl_compiler(Tapioca::Dsl::Compilers::FastStruct)
        end

        def teardown
          assert_empty generated_errors
        end

        def test_gathered_constants_gathers_no_constants_with_no_fast_struct_classes
          assert_empty gathered_constants
        end

        def test_gathered_constants_gathers_only_fast_struct_classes_and_modules
          add_ruby_file("content.rb", <<~RUBY)
            class Post < FastStruct::Struct
            end

            class User < FastStruct::Struct
            end

            class Comment
            end

            module Editable
            end
          RUBY

          assert_equal ["Post", "User"], gathered_constants
        end

        def test_gathered_constants_ignores_fast_structs_without_a_name
          add_ruby_file("content.rb", <<~RUBY)
            post = Class.new(FastStruct::Struct)
          RUBY

          assert_empty gathered_constants
        end

        def test_decorate_generates_empty_RBI_file_if_there_are_no_fast_struct_properties
          add_ruby_file("post.rb", <<~RUBY)
            class Post < FastStruct::Struct
            end
          RUBY

          assert_equal <<~RBI, rbi_for(:Post)
            # typed: strong
          RBI
        end

        def test_decorate_generates_RBI_file_for_simple_fast_structs
          add_ruby_file("post.rb", <<~RUBY)
            class Post < FastStruct::Struct
              define do
                prop :title, String
              end
            end
          RUBY

          assert_equal <<~RBI, rbi_for(:Post)
            # typed: strong

            class Post
              include FastStructGeneratedMethods

              module FastStructGeneratedMethods
                sig { returns(::String) }
                def title; end

                sig { params(title: ::String).returns(::String) }
                def title=(title); end
              end
            end
          RBI
        end

        def test_decorate_generates_RBI_file_for_const_fast_structs
          add_ruby_file("post.rb", <<~RUBY)
            class Post < FastStruct::Struct
              define do
                const :title, String
              end
            end
          RUBY

          assert_equal <<~RBI, rbi_for(:Post)
            # typed: strong

            class Post
              include FastStructGeneratedMethods

              module FastStructGeneratedMethods
                sig { returns(::String) }
                def title; end
              end
            end
          RBI
        end

        def test_decorate_generates_RBI_file_for_sorbet_typed_props
          add_ruby_file("post.rb", <<~RUBY)
            class Post < FastStruct::Struct
              define do
                const :title, T.nilable(String)
              end
            end
          RUBY

          assert_equal <<~RBI, rbi_for(:Post)
            # typed: strong

            class Post
              include FastStructGeneratedMethods

              module FastStructGeneratedMethods
                sig { returns(T.nilable(::String)) }
                def title; end
              end
            end
          RBI
        end

        def test_decorating_sorbet_mixed_with_dry_types
          add_ruby_file("types.rb", <<~RUBY)
            require "dry/types"

            module Types
              include Dry.Types()
            end
          RUBY

          add_ruby_file("post.rb", <<~RUBY)
            class Post < FastStruct::Struct
              define do
                const :title, Types::String.constrained(format: /\w+/) | Types::Nil
                const :body, T.nilable(String)
              end
            end
          RUBY

          assert_equal <<~RBI, rbi_for(:Post)
            # typed: strong

            class Post
              include FastStructGeneratedMethods

              module FastStructGeneratedMethods
                sig { returns(T.nilable(::String)) }
                def body; end

                sig { returns(::T.nilable(::String)) }
                def title; end
              end
            end
          RBI
        end

        def test_decorating_all_manner_of_dry_types
          add_ruby_file("types.rb", <<~RUBY)
            require "dry/types"

            module Types
              include Dry.Types()
            end
          RUBY

          add_ruby_file("post.rb", <<~RUBY)
            class Post < FastStruct::Struct
              define do
                const :a, Types::Nil | Types::String
                const :b, Types::Hash.schema(name: Types::String)
                const :c, Types::Array.of(Types::String)
                const :d, Types::Integer.constrained(gt: 1, lt: 10)
                const :e, Types.Constructor(String)
                const :f, Types::String.enum("hi", "bye")
                const :g, Types::Hash
                const :h, Types::Hash.map(Types::Integer, Types::String)
                const :i, Types::True | Types::False | Types::Nil
                const :j, Types::Any
                const :k, Types::Nil
                const :l, Types.Instance(Range)
                const :m, Types.Instance(Set)
                const :n, Types.Instance(TrueClass)
                const :o, Types::Any | Types::Nil
                const :p, Types::Integer | Types::String
              end
            end
          RUBY

          assert_equal <<~RBI, rbi_for(:Post)
            # typed: strong

            class Post
              include FastStructGeneratedMethods

              module FastStructGeneratedMethods
                sig { returns(::T.nilable(::String)) }
                def a; end

                sig { returns(::T::Hash[::Symbol, ::T.untyped]) }
                def b; end

                sig { returns(::T::Array[::String]) }
                def c; end

                sig { returns(::Integer) }
                def d; end

                sig { returns(::String) }
                def e; end

                sig { returns(::String) }
                def f; end

                sig { returns(::T::Hash[::T.untyped, ::T.untyped]) }
                def g; end

                sig { returns(::T::Hash[::Integer, ::String]) }
                def h; end

                sig { returns(::T.nilable(::T::Boolean)) }
                def i; end

                sig { returns(::T.untyped) }
                def j; end

                sig { returns(::NilClass) }
                def k; end

                sig { returns(::T::Range[::T.untyped]) }
                def l; end

                sig { returns(::T::Set[::T.untyped]) }
                def m; end

                sig { returns(::T::Boolean) }
                def n; end

                sig { returns(::T.nilable(::T.untyped)) }
                def o; end

                sig { returns(::T.any(::Integer, ::String)) }
                def p; end
              end
            end
          RBI
        end
      end
    end
  end
end
