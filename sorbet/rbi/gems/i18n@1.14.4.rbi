# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `i18n` gem.
# Please instead update this file by running `bin/tapioca gem i18n`.

# source://i18n//lib/i18n/gettext/po_parser.rb#15
module GetText; end

# source://i18n//lib/i18n/gettext/po_parser.rb#17
class GetText::PoParser < ::Racc::Parser
  # source://i18n//lib/i18n/gettext/po_parser.rb#19
  def _(x); end

  def _reduce_10(val, _values, result); end
  def _reduce_12(val, _values, result); end
  def _reduce_13(val, _values, result); end
  def _reduce_14(val, _values, result); end
  def _reduce_15(val, _values, result); end
  def _reduce_5(val, _values, result); end
  def _reduce_8(val, _values, result); end
  def _reduce_9(val, _values, result); end

  # source://i18n//lib/i18n/gettext/po_parser.rb#323
  def _reduce_none(val, _values, result); end

  def next_token; end
  def on_comment(comment); end
  def on_message(msgid, msgstr); end
  def parse(str, data, ignore_fuzzy = T.unsafe(nil)); end
  def unescape(orig); end
end

# source://i18n//lib/i18n/gettext/po_parser.rb#184
GetText::PoParser::Racc_arg = T.let(T.unsafe(nil), Array)

# source://i18n//lib/i18n/gettext/po_parser.rb#221
GetText::PoParser::Racc_debug_parser = T.let(T.unsafe(nil), TrueClass)

# source://i18n//lib/i18n/gettext/po_parser.rb#200
GetText::PoParser::Racc_token_to_s_table = T.let(T.unsafe(nil), Array)

# source://i18n//lib/i18n/version.rb#3
module I18n
  extend ::I18n::Base

  class << self
    # source://i18n//lib/i18n/backend/cache.rb#64
    def cache_key_digest; end

    # source://i18n//lib/i18n/backend/cache.rb#68
    def cache_key_digest=(key_digest); end

    # source://i18n//lib/i18n/backend/cache.rb#56
    def cache_namespace; end

    # source://i18n//lib/i18n/backend/cache.rb#60
    def cache_namespace=(namespace); end

    # source://i18n//lib/i18n/backend/cache.rb#48
    def cache_store; end

    # source://i18n//lib/i18n/backend/cache.rb#52
    def cache_store=(store); end

    # source://i18n//lib/i18n/backend/fallbacks.rb#17
    def fallbacks; end

    # source://i18n//lib/i18n/backend/fallbacks.rb#23
    def fallbacks=(fallbacks); end

    # source://i18n//lib/i18n/interpolate/ruby.rb#23
    def interpolate(string, values); end

    # source://i18n//lib/i18n/interpolate/ruby.rb#29
    def interpolate_hash(string, values); end

    # source://i18n//lib/i18n.rb#37
    def new_double_nested_cache; end

    # source://i18n//lib/i18n/backend/cache.rb#72
    def perform_caching?; end

    # source://i18n//lib/i18n.rb#45
    def reserve_key(key); end

    # source://i18n//lib/i18n.rb#50
    def reserved_keys_pattern; end
  end
end

# source://i18n//lib/i18n/exceptions.rb#16
class I18n::ArgumentError < ::ArgumentError; end

# source://i18n//lib/i18n/backend.rb#4
module I18n::Backend; end

# source://i18n//lib/i18n/backend/base.rb#8
module I18n::Backend::Base
  include ::I18n::Backend::Transliterator

  # source://i18n//lib/i18n/backend/base.rb#96
  def available_locales; end

  # source://i18n//lib/i18n/backend/base.rb#104
  def eager_load!; end

  # source://i18n//lib/i18n/backend/base.rb#70
  def exists?(locale, key, options = T.unsafe(nil)); end

  # source://i18n//lib/i18n/backend/base.rb#14
  def load_translations(*filenames); end

  # source://i18n//lib/i18n/backend/base.rb#77
  def localize(locale, object, format = T.unsafe(nil), options = T.unsafe(nil)); end

  # source://i18n//lib/i18n/backend/base.rb#100
  def reload!; end

  # source://i18n//lib/i18n/backend/base.rb#24
  def store_translations(locale, data, options = T.unsafe(nil)); end

  # source://i18n//lib/i18n/backend/base.rb#28
  def translate(locale, key, options = T.unsafe(nil)); end

  protected

  # source://i18n//lib/i18n/backend/base.rb#209
  def deep_interpolate(locale, data, values = T.unsafe(nil)); end

  # source://i18n//lib/i18n/backend/base.rb#127
  def default(locale, object, subject, options = T.unsafe(nil)); end

  # source://i18n//lib/i18n/backend/base.rb#110
  def eager_loaded?; end

  # source://i18n//lib/i18n/backend/base.rb#193
  def interpolate(locale, subject, values = T.unsafe(nil)); end

  # source://i18n//lib/i18n/backend/base.rb#232
  def load_file(filename); end

  # source://i18n//lib/i18n/backend/base.rb#268
  def load_json(filename); end

  # source://i18n//lib/i18n/backend/base.rb#246
  def load_rb(filename); end

  # source://i18n//lib/i18n/backend/base.rb#253
  def load_yaml(filename); end

  # source://i18n//lib/i18n/backend/base.rb#253
  def load_yml(filename); end

  # source://i18n//lib/i18n/backend/base.rb#115
  def lookup(locale, key, scope = T.unsafe(nil), options = T.unsafe(nil)); end

  # source://i18n//lib/i18n/backend/base.rb#300
  def pluralization_key(entry, count); end

  # source://i18n//lib/i18n/backend/base.rb#174
  def pluralize(locale, entry, count); end

  # source://i18n//lib/i18n/backend/base.rb#149
  def resolve(locale, object, subject, options = T.unsafe(nil)); end

  # source://i18n//lib/i18n/backend/base.rb#149
  def resolve_entry(locale, object, subject, options = T.unsafe(nil)); end

  # source://i18n//lib/i18n/backend/base.rb#119
  def subtrees?; end

  # source://i18n//lib/i18n/backend/base.rb#281
  def translate_localization_format(locale, object, format, options); end
end

# source://i18n//lib/i18n/backend/cache.rb#79
module I18n::Backend::Cache
  # source://i18n//lib/i18n/backend/cache.rb#80
  def translate(locale, key, options = T.unsafe(nil)); end

  protected

  # source://i18n//lib/i18n/backend/cache.rb#93
  def _fetch(cache_key, &block); end

  # source://i18n//lib/i18n/backend/cache.rb#101
  def cache_key(locale, key, options); end

  # source://i18n//lib/i18n/backend/cache.rb#86
  def fetch(cache_key, &block); end

  private

  # source://i18n//lib/i18n/backend/cache.rb#108
  def digest_item(key); end
end

# source://i18n//lib/i18n/backend/cache_file.rb#8
module I18n::Backend::CacheFile
  # source://i18n//lib/i18n/backend/cache_file.rb#11
  def path_roots; end

  # source://i18n//lib/i18n/backend/cache_file.rb#11
  def path_roots=(_arg0); end

  protected

  # source://i18n//lib/i18n/backend/cache_file.rb#17
  def load_file(filename); end

  # source://i18n//lib/i18n/backend/cache_file.rb#28
  def normalized_path(file); end
end

# source://i18n//lib/i18n/backend/cascade.rb#35
module I18n::Backend::Cascade
  # source://i18n//lib/i18n/backend/cascade.rb#36
  def lookup(locale, key, scope = T.unsafe(nil), options = T.unsafe(nil)); end
end

# source://i18n//lib/i18n/backend/chain.rb#21
class I18n::Backend::Chain
  include ::I18n::Backend::Transliterator
  include ::I18n::Backend::Base
  include ::I18n::Backend::Chain::Implementation
end

# source://i18n//lib/i18n/backend/chain.rb#22
module I18n::Backend::Chain::Implementation
  include ::I18n::Backend::Transliterator
  include ::I18n::Backend::Base

  # source://i18n//lib/i18n/backend/chain.rb#27
  def initialize(*backends); end

  # source://i18n//lib/i18n/backend/chain.rb#52
  def available_locales; end

  # source://i18n//lib/i18n/backend/chain.rb#25
  def backends; end

  # source://i18n//lib/i18n/backend/chain.rb#25
  def backends=(_arg0); end

  # source://i18n//lib/i18n/backend/chain.rb#44
  def eager_load!; end

  # source://i18n//lib/i18n/backend/chain.rb#76
  def exists?(locale, key, options = T.unsafe(nil)); end

  # source://i18n//lib/i18n/backend/chain.rb#31
  def initialized?; end

  # source://i18n//lib/i18n/backend/chain.rb#82
  def localize(locale, object, format = T.unsafe(nil), options = T.unsafe(nil)); end

  # source://i18n//lib/i18n/backend/chain.rb#40
  def reload!; end

  # source://i18n//lib/i18n/backend/chain.rb#48
  def store_translations(locale, data, options = T.unsafe(nil)); end

  # source://i18n//lib/i18n/backend/chain.rb#56
  def translate(locale, key, default_options = T.unsafe(nil)); end

  protected

  # source://i18n//lib/i18n/backend/chain.rb#92
  def init_translations; end

  # source://i18n//lib/i18n/backend/chain.rb#108
  def namespace_lookup?(result, options); end

  # source://i18n//lib/i18n/backend/chain.rb#98
  def translations; end

  private

  # source://i18n//lib/i18n/backend/chain.rb#117
  def _deep_merge(hash, other_hash); end
end

# source://i18n//lib/i18n/backend/fallbacks.rb#30
module I18n::Backend::Fallbacks
  # source://i18n//lib/i18n/backend/fallbacks.rb#94
  def exists?(locale, key, options = T.unsafe(nil)); end

  # source://i18n//lib/i18n/backend/fallbacks.rb#85
  def extract_non_symbol_default!(options); end

  # source://i18n//lib/i18n/backend/fallbacks.rb#67
  def resolve_entry(locale, object, subject, options = T.unsafe(nil)); end

  # source://i18n//lib/i18n/backend/fallbacks.rb#41
  def translate(locale, key, options = T.unsafe(nil)); end

  private

  # source://i18n//lib/i18n/backend/fallbacks.rb#110
  def on_fallback(_original_locale, _fallback_locale, _key, _options); end
end

# source://i18n//lib/i18n/backend/flatten.rb#13
module I18n::Backend::Flatten
  # source://i18n//lib/i18n/backend/flatten.rb#59
  def flatten_keys(hash, escape, prev_key = T.unsafe(nil), &block); end

  # source://i18n//lib/i18n/backend/flatten.rb#74
  def flatten_translations(locale, data, escape, subtree); end

  # source://i18n//lib/i18n/backend/flatten.rb#50
  def links; end

  # source://i18n//lib/i18n/backend/flatten.rb#44
  def normalize_flat_keys(locale, key, scope, separator); end

  protected

  # source://i18n//lib/i18n/backend/flatten.rb#112
  def escape_default_separator(key); end

  # source://i18n//lib/i18n/backend/flatten.rb#106
  def find_link(locale, key); end

  # source://i18n//lib/i18n/backend/flatten.rb#93
  def resolve_link(locale, key); end

  # source://i18n//lib/i18n/backend/flatten.rb#89
  def store_link(locale, key, link); end

  class << self
    # source://i18n//lib/i18n/backend/flatten.rb#38
    def escape_default_separator(key); end

    # source://i18n//lib/i18n/backend/flatten.rb#20
    def normalize_flat_keys(locale, key, scope, separator); end
  end
end

# source://i18n//lib/i18n/backend/flatten.rb#15
I18n::Backend::Flatten::FLATTEN_SEPARATOR = T.let(T.unsafe(nil), String)

# source://i18n//lib/i18n/backend/flatten.rb#14
I18n::Backend::Flatten::SEPARATOR_ESCAPE_CHAR = T.let(T.unsafe(nil), String)

# source://i18n//lib/i18n/backend/gettext.rb#33
module I18n::Backend::Gettext
  protected

  # source://i18n//lib/i18n/backend/gettext.rb#41
  def load_po(filename); end

  # source://i18n//lib/i18n/backend/gettext.rb#51
  def normalize(locale, data); end

  # source://i18n//lib/i18n/backend/gettext.rb#68
  def normalize_pluralization(locale, key, value); end

  # source://i18n//lib/i18n/backend/gettext.rb#47
  def parse(filename); end
end

# source://i18n//lib/i18n/backend/gettext.rb#34
class I18n::Backend::Gettext::PoData < ::Hash
  # source://i18n//lib/i18n/backend/gettext.rb#35
  def set_comment(msgid_or_sym, comment); end
end

# source://i18n//lib/i18n/backend/interpolation_compiler.rb#20
module I18n::Backend::InterpolationCompiler
  # source://i18n//lib/i18n/backend/interpolation_compiler.rb#97
  def interpolate(locale, string, values); end

  # source://i18n//lib/i18n/backend/interpolation_compiler.rb#107
  def store_translations(locale, data, options = T.unsafe(nil)); end

  protected

  # source://i18n//lib/i18n/backend/interpolation_compiler.rb#113
  def compile_all_strings_in(data); end
end

# source://i18n//lib/i18n/backend/interpolation_compiler.rb#21
module I18n::Backend::InterpolationCompiler::Compiler
  extend ::I18n::Backend::InterpolationCompiler::Compiler

  # source://i18n//lib/i18n/backend/interpolation_compiler.rb#26
  def compile_if_an_interpolation(string); end

  # source://i18n//lib/i18n/backend/interpolation_compiler.rb#38
  def interpolated_str?(str); end

  protected

  # source://i18n//lib/i18n/backend/interpolation_compiler.rb#58
  def compile_interpolation_token(key); end

  # source://i18n//lib/i18n/backend/interpolation_compiler.rb#48
  def compiled_interpolation_body(str); end

  # source://i18n//lib/i18n/backend/interpolation_compiler.rb#71
  def direct_key(key); end

  # source://i18n//lib/i18n/backend/interpolation_compiler.rb#91
  def escape_key_sym(key); end

  # source://i18n//lib/i18n/backend/interpolation_compiler.rb#87
  def escape_plain_str(str); end

  # source://i18n//lib/i18n/backend/interpolation_compiler.rb#54
  def handle_interpolation_token(token); end

  # source://i18n//lib/i18n/backend/interpolation_compiler.rb#67
  def interpolate_key(key); end

  # source://i18n//lib/i18n/backend/interpolation_compiler.rb#62
  def interpolate_or_raise_missing(key); end

  # source://i18n//lib/i18n/backend/interpolation_compiler.rb#79
  def missing_key(key); end

  # source://i18n//lib/i18n/backend/interpolation_compiler.rb#75
  def nil_key(key); end

  # source://i18n//lib/i18n/backend/interpolation_compiler.rb#83
  def reserved_key(key); end

  # source://i18n//lib/i18n/backend/interpolation_compiler.rb#44
  def tokenize(str); end
end

# source://i18n//lib/i18n/backend/interpolation_compiler.rb#24
I18n::Backend::InterpolationCompiler::Compiler::TOKENIZER = T.let(T.unsafe(nil), Regexp)

# source://i18n//lib/i18n/backend/key_value.rb#69
class I18n::Backend::KeyValue
  include ::I18n::Backend::Flatten
  include ::I18n::Backend::Transliterator
  include ::I18n::Backend::Base
  include ::I18n::Backend::KeyValue::Implementation
end

# source://i18n//lib/i18n/backend/key_value.rb#70
module I18n::Backend::KeyValue::Implementation
  include ::I18n::Backend::Flatten
  include ::I18n::Backend::Transliterator
  include ::I18n::Backend::Base

  # source://i18n//lib/i18n/backend/key_value.rb#75
  def initialize(store, subtrees = T.unsafe(nil)); end

  # source://i18n//lib/i18n/backend/key_value.rb#102
  def available_locales; end

  # source://i18n//lib/i18n/backend/key_value.rb#79
  def initialized?; end

  # source://i18n//lib/i18n/backend/key_value.rb#71
  def store; end

  # source://i18n//lib/i18n/backend/key_value.rb#71
  def store=(_arg0); end

  # source://i18n//lib/i18n/backend/key_value.rb#83
  def store_translations(locale, data, options = T.unsafe(nil)); end

  protected

  # source://i18n//lib/i18n/backend/key_value.rb#124
  def init_translations; end

  # source://i18n//lib/i18n/backend/key_value.rb#136
  def lookup(locale, key, scope = T.unsafe(nil), options = T.unsafe(nil)); end

  # source://i18n//lib/i18n/backend/key_value.rb#150
  def pluralize(locale, entry, count); end

  # source://i18n//lib/i18n/backend/key_value.rb#132
  def subtrees?; end

  # source://i18n//lib/i18n/backend/key_value.rb#115
  def translations; end
end

# source://i18n//lib/i18n/backend/key_value.rb#161
class I18n::Backend::KeyValue::SubtreeProxy
  # source://i18n//lib/i18n/backend/key_value.rb#162
  def initialize(master_key, store); end

  # source://i18n//lib/i18n/backend/key_value.rb#172
  def [](key); end

  # source://i18n//lib/i18n/backend/key_value.rb#168
  def has_key?(key); end

  # source://i18n//lib/i18n/backend/key_value.rb#196
  def inspect; end

  # source://i18n//lib/i18n/backend/key_value.rb#188
  def instance_of?(klass); end

  # source://i18n//lib/i18n/backend/key_value.rb#183
  def is_a?(klass); end

  # source://i18n//lib/i18n/backend/key_value.rb#183
  def kind_of?(klass); end

  # source://i18n//lib/i18n/backend/key_value.rb#192
  def nil?; end
end

# source://i18n//lib/i18n/backend/lazy_loadable.rb#65
class I18n::Backend::LazyLoadable < ::I18n::Backend::Simple
  # source://i18n//lib/i18n/backend/lazy_loadable.rb#66
  def initialize(lazy_load: T.unsafe(nil)); end

  # source://i18n//lib/i18n/backend/lazy_loadable.rb#99
  def available_locales; end

  # source://i18n//lib/i18n/backend/lazy_loadable.rb#90
  def eager_load!; end

  # source://i18n//lib/i18n/backend/lazy_loadable.rb#71
  def initialized?; end

  # source://i18n//lib/i18n/backend/lazy_loadable.rb#107
  def lookup(locale, key, scope = T.unsafe(nil), options = T.unsafe(nil)); end

  # source://i18n//lib/i18n/backend/lazy_loadable.rb#80
  def reload!; end

  protected

  # source://i18n//lib/i18n/backend/lazy_loadable.rb#121
  def init_translations; end

  # source://i18n//lib/i18n/backend/lazy_loadable.rb#133
  def initialized_locales; end

  private

  # source://i18n//lib/i18n/backend/lazy_loadable.rb#175
  def assert_file_named_correctly!(file, translations); end

  # source://i18n//lib/i18n/backend/lazy_loadable.rb#167
  def filenames_for_current_locale; end

  # source://i18n//lib/i18n/backend/lazy_loadable.rb#139
  def lazy_load?; end

  # source://i18n//lib/i18n/backend/lazy_loadable.rb#152
  def load_translations_and_collect_file_errors(files); end
end

# source://i18n//lib/i18n/backend/lazy_loadable.rb#143
class I18n::Backend::LazyLoadable::FilenameIncorrect < ::StandardError
  # source://i18n//lib/i18n/backend/lazy_loadable.rb#144
  def initialize(file, expected_locale, unexpected_locales); end
end

# source://i18n//lib/i18n/backend/lazy_loadable.rb#55
class I18n::Backend::LocaleExtractor
  class << self
    # source://i18n//lib/i18n/backend/lazy_loadable.rb#57
    def locale_from_path(path); end
  end
end

# source://i18n//lib/i18n/backend/memoize.rb#14
module I18n::Backend::Memoize
  # source://i18n//lib/i18n/backend/memoize.rb#15
  def available_locales; end

  # source://i18n//lib/i18n/backend/memoize.rb#29
  def eager_load!; end

  # source://i18n//lib/i18n/backend/memoize.rb#24
  def reload!; end

  # source://i18n//lib/i18n/backend/memoize.rb#19
  def store_translations(locale, data, options = T.unsafe(nil)); end

  protected

  # source://i18n//lib/i18n/backend/memoize.rb#37
  def lookup(locale, key, scope = T.unsafe(nil), options = T.unsafe(nil)); end

  # source://i18n//lib/i18n/backend/memoize.rb#44
  def memoized_lookup; end

  # source://i18n//lib/i18n/backend/memoize.rb#48
  def reset_memoizations!(locale = T.unsafe(nil)); end
end

# source://i18n//lib/i18n/backend/metadata.rb#21
module I18n::Backend::Metadata
  # source://i18n//lib/i18n/backend/metadata.rb#52
  def interpolate(locale, entry, values = T.unsafe(nil)); end

  # source://i18n//lib/i18n/backend/metadata.rb#57
  def pluralize(locale, entry, count); end

  # source://i18n//lib/i18n/backend/metadata.rb#40
  def translate(locale, key, options = T.unsafe(nil)); end

  protected

  # source://i18n//lib/i18n/backend/metadata.rb#63
  def with_metadata(metadata, &block); end

  class << self
    # source://i18n//lib/i18n/backend/metadata.rb#23
    def included(base); end
  end
end

# source://i18n//lib/i18n/backend/pluralization.rb#16
module I18n::Backend::Pluralization
  # source://i18n//lib/i18n/backend/pluralization.rb#39
  def pluralize(locale, entry, count); end

  protected

  # source://i18n//lib/i18n/backend/pluralization.rb#81
  def pluralizer(locale); end

  # source://i18n//lib/i18n/backend/pluralization.rb#77
  def pluralizers; end

  private

  # source://i18n//lib/i18n/backend/pluralization.rb#89
  def symbolic_count(count); end
end

# source://i18n//lib/i18n/backend/simple.rb#21
class I18n::Backend::Simple
  include ::I18n::Backend::Transliterator
  include ::I18n::Backend::Base
  include ::I18n::Backend::Simple::Implementation
end

# source://i18n//lib/i18n/backend/simple.rb#22
module I18n::Backend::Simple::Implementation
  include ::I18n::Backend::Transliterator
  include ::I18n::Backend::Base

  # source://i18n//lib/i18n/backend/simple.rb#49
  def available_locales; end

  # source://i18n//lib/i18n/backend/simple.rb#64
  def eager_load!; end

  # source://i18n//lib/i18n/backend/simple.rb#28
  def initialized?; end

  # source://i18n//lib/i18n/backend/simple.rb#58
  def reload!; end

  # source://i18n//lib/i18n/backend/simple.rb#36
  def store_translations(locale, data, options = T.unsafe(nil)); end

  # source://i18n//lib/i18n/backend/simple.rb#69
  def translations(do_init: T.unsafe(nil)); end

  protected

  # source://i18n//lib/i18n/backend/simple.rb#83
  def init_translations; end

  # source://i18n//lib/i18n/backend/simple.rb#93
  def lookup(locale, key, scope = T.unsafe(nil), options = T.unsafe(nil)); end
end

# source://i18n//lib/i18n/backend/simple.rb#26
I18n::Backend::Simple::Implementation::MUTEX = T.let(T.unsafe(nil), Thread::Mutex)

# source://i18n//lib/i18n/backend/transliterator.rb#6
module I18n::Backend::Transliterator
  # source://i18n//lib/i18n/backend/transliterator.rb#11
  def transliterate(locale, string, replacement = T.unsafe(nil)); end

  class << self
    # source://i18n//lib/i18n/backend/transliterator.rb#19
    def get(rule = T.unsafe(nil)); end
  end
end

# source://i18n//lib/i18n/backend/transliterator.rb#7
I18n::Backend::Transliterator::DEFAULT_REPLACEMENT_CHAR = T.let(T.unsafe(nil), String)

# source://i18n//lib/i18n/backend/transliterator.rb#42
class I18n::Backend::Transliterator::HashTransliterator
  # source://i18n//lib/i18n/backend/transliterator.rb#74
  def initialize(rule = T.unsafe(nil)); end

  # source://i18n//lib/i18n/backend/transliterator.rb#80
  def transliterate(string, replacement = T.unsafe(nil)); end

  private

  # source://i18n//lib/i18n/backend/transliterator.rb#100
  def add(hash); end

  # source://i18n//lib/i18n/backend/transliterator.rb#93
  def add_default_approximations; end

  # source://i18n//lib/i18n/backend/transliterator.rb#89
  def approximations; end
end

# source://i18n//lib/i18n/backend/transliterator.rb#43
I18n::Backend::Transliterator::HashTransliterator::DEFAULT_APPROXIMATIONS = T.let(T.unsafe(nil), Hash)

# source://i18n//lib/i18n/backend/transliterator.rb#30
class I18n::Backend::Transliterator::ProcTransliterator
  # source://i18n//lib/i18n/backend/transliterator.rb#31
  def initialize(rule); end

  # source://i18n//lib/i18n/backend/transliterator.rb#35
  def transliterate(string, replacement = T.unsafe(nil)); end
end

# source://i18n//lib/i18n.rb#54
module I18n::Base
  # source://i18n//lib/i18n.rb#69
  def available_locales; end

  # source://i18n//lib/i18n.rb#73
  def available_locales=(value); end

  # source://i18n//lib/i18n.rb#355
  def available_locales_initialized?; end

  # source://i18n//lib/i18n.rb#69
  def backend; end

  # source://i18n//lib/i18n.rb#73
  def backend=(value); end

  # source://i18n//lib/i18n.rb#56
  def config; end

  # source://i18n//lib/i18n.rb#61
  def config=(value); end

  # source://i18n//lib/i18n.rb#69
  def default_locale; end

  # source://i18n//lib/i18n.rb#73
  def default_locale=(value); end

  # source://i18n//lib/i18n.rb#69
  def default_separator; end

  # source://i18n//lib/i18n.rb#73
  def default_separator=(value); end

  # source://i18n//lib/i18n.rb#90
  def eager_load!; end

  # source://i18n//lib/i18n.rb#69
  def enforce_available_locales; end

  # source://i18n//lib/i18n.rb#349
  def enforce_available_locales!(locale); end

  # source://i18n//lib/i18n.rb#73
  def enforce_available_locales=(value); end

  # source://i18n//lib/i18n.rb#69
  def exception_handler; end

  # source://i18n//lib/i18n.rb#73
  def exception_handler=(value); end

  # source://i18n//lib/i18n.rb#235
  def exists?(key, _locale = T.unsafe(nil), locale: T.unsafe(nil), **options); end

  # source://i18n//lib/i18n.rb#304
  def l(object, locale: T.unsafe(nil), format: T.unsafe(nil), **options); end

  # source://i18n//lib/i18n.rb#69
  def load_path; end

  # source://i18n//lib/i18n.rb#73
  def load_path=(value); end

  # source://i18n//lib/i18n.rb#69
  def locale; end

  # source://i18n//lib/i18n.rb#73
  def locale=(value); end

  # source://i18n//lib/i18n.rb#344
  def locale_available?(locale); end

  # source://i18n//lib/i18n.rb#304
  def localize(object, locale: T.unsafe(nil), format: T.unsafe(nil), **options); end

  # source://i18n//lib/i18n.rb#332
  def normalize_keys(locale, key, scope, separator = T.unsafe(nil)); end

  # source://i18n//lib/i18n.rb#82
  def reload!; end

  # source://i18n//lib/i18n.rb#210
  def t(key = T.unsafe(nil), throw: T.unsafe(nil), raise: T.unsafe(nil), locale: T.unsafe(nil), **options); end

  # source://i18n//lib/i18n.rb#229
  def t!(key, **options); end

  # source://i18n//lib/i18n.rb#210
  def translate(key = T.unsafe(nil), throw: T.unsafe(nil), raise: T.unsafe(nil), locale: T.unsafe(nil), **options); end

  # source://i18n//lib/i18n.rb#229
  def translate!(key, **options); end

  # source://i18n//lib/i18n.rb#293
  def transliterate(key, throw: T.unsafe(nil), raise: T.unsafe(nil), locale: T.unsafe(nil), replacement: T.unsafe(nil), **options); end

  # source://i18n//lib/i18n.rb#315
  def with_locale(tmp_locale = T.unsafe(nil)); end

  private

  # source://i18n//lib/i18n.rb#391
  def handle_exception(handling, exception, locale, key, options); end

  # source://i18n//lib/i18n.rb#409
  def normalize_key(key, separator); end

  # source://i18n//lib/i18n.rb#361
  def translate_key(key, throw, raise, locale, backend, options); end
end

# source://i18n//lib/i18n/config.rb#6
class I18n::Config
  # source://i18n//lib/i18n/config.rb#43
  def available_locales; end

  # source://i18n//lib/i18n/config.rb#57
  def available_locales=(locales); end

  # source://i18n//lib/i18n/config.rb#64
  def available_locales_initialized?; end

  # source://i18n//lib/i18n/config.rb#50
  def available_locales_set; end

  # source://i18n//lib/i18n/config.rb#20
  def backend; end

  # source://i18n//lib/i18n/config.rb#25
  def backend=(backend); end

  # source://i18n//lib/i18n/config.rb#70
  def clear_available_locales_set; end

  # source://i18n//lib/i18n/config.rb#30
  def default_locale; end

  # source://i18n//lib/i18n/config.rb#35
  def default_locale=(locale); end

  # source://i18n//lib/i18n/config.rb#75
  def default_separator; end

  # source://i18n//lib/i18n/config.rb#80
  def default_separator=(separator); end

  # source://i18n//lib/i18n/config.rb#141
  def enforce_available_locales; end

  # source://i18n//lib/i18n/config.rb#145
  def enforce_available_locales=(enforce_available_locales); end

  # source://i18n//lib/i18n/config.rb#86
  def exception_handler; end

  # source://i18n//lib/i18n/config.rb#91
  def exception_handler=(exception_handler); end

  # source://i18n//lib/i18n/config.rb#151
  def interpolation_patterns; end

  # source://i18n//lib/i18n/config.rb#161
  def interpolation_patterns=(interpolation_patterns); end

  # source://i18n//lib/i18n/config.rb#126
  def load_path; end

  # source://i18n//lib/i18n/config.rb#132
  def load_path=(load_path); end

  # source://i18n//lib/i18n/config.rb#9
  def locale; end

  # source://i18n//lib/i18n/config.rb#14
  def locale=(locale); end

  # source://i18n//lib/i18n/config.rb#97
  def missing_interpolation_argument_handler; end

  # source://i18n//lib/i18n/config.rb#114
  def missing_interpolation_argument_handler=(exception_handler); end
end

# source://i18n//lib/i18n/interpolate/ruby.rb#7
I18n::DEFAULT_INTERPOLATION_PATTERNS = T.let(T.unsafe(nil), Array)

# source://i18n//lib/i18n/exceptions.rb#18
class I18n::Disabled < ::I18n::ArgumentError
  # source://i18n//lib/i18n/exceptions.rb#19
  def initialize(method); end
end

# source://i18n//lib/i18n.rb#35
I18n::EMPTY_HASH = T.let(T.unsafe(nil), Hash)

# source://i18n//lib/i18n/exceptions.rb#6
class I18n::ExceptionHandler
  # source://i18n//lib/i18n/exceptions.rb#7
  def call(exception, _locale, _key, _options); end
end

# source://i18n//lib/i18n/gettext.rb#4
module I18n::Gettext
  class << self
    # source://i18n//lib/i18n/gettext.rb#21
    def extract_scope(msgid, separator); end

    # source://i18n//lib/i18n/gettext.rb#17
    def plural_keys(*args); end
  end
end

# source://i18n//lib/i18n/gettext.rb#6
I18n::Gettext::CONTEXT_SEPARATOR = T.let(T.unsafe(nil), String)

# source://i18n//lib/i18n/gettext/helpers.rb#11
module I18n::Gettext::Helpers
  # source://i18n//lib/i18n/gettext/helpers.rb#17
  def N_(msgsid); end

  # source://i18n//lib/i18n/gettext/helpers.rb#21
  def _(msgid, options = T.unsafe(nil)); end

  # source://i18n//lib/i18n/gettext/helpers.rb#21
  def gettext(msgid, options = T.unsafe(nil)); end

  # source://i18n//lib/i18n/gettext/helpers.rb#38
  def n_(msgid, msgid_plural, n = T.unsafe(nil)); end

  # source://i18n//lib/i18n/gettext/helpers.rb#38
  def ngettext(msgid, msgid_plural, n = T.unsafe(nil)); end

  # source://i18n//lib/i18n/gettext/helpers.rb#61
  def np_(msgctxt, msgid, msgid_plural, n = T.unsafe(nil)); end

  # source://i18n//lib/i18n/gettext/helpers.rb#61
  def npgettext(msgctxt, msgid, msgid_plural, n = T.unsafe(nil)); end

  # source://i18n//lib/i18n/gettext/helpers.rb#46
  def ns_(msgid, msgid_plural, n = T.unsafe(nil), separator = T.unsafe(nil)); end

  # source://i18n//lib/i18n/gettext/helpers.rb#46
  def nsgettext(msgid, msgid_plural, n = T.unsafe(nil), separator = T.unsafe(nil)); end

  # source://i18n//lib/i18n/gettext/helpers.rb#32
  def p_(msgctxt, msgid); end

  # source://i18n//lib/i18n/gettext/helpers.rb#32
  def pgettext(msgctxt, msgid); end

  # source://i18n//lib/i18n/gettext/helpers.rb#26
  def s_(msgid, separator = T.unsafe(nil)); end

  # source://i18n//lib/i18n/gettext/helpers.rb#26
  def sgettext(msgid, separator = T.unsafe(nil)); end
end

# source://i18n//lib/i18n/gettext.rb#5
I18n::Gettext::PLURAL_SEPARATOR = T.let(T.unsafe(nil), String)

# source://i18n//lib/i18n/interpolate/ruby.rb#12
I18n::INTERPOLATION_PATTERN = T.let(T.unsafe(nil), Regexp)

# source://i18n//lib/i18n/interpolate/ruby.rb#15
I18n::INTERPOLATION_PATTERNS_CACHE = T.let(T.unsafe(nil), Hash)

# source://i18n//lib/i18n/exceptions.rb#134
class I18n::InvalidFilenames < ::I18n::ArgumentError
  # source://i18n//lib/i18n/exceptions.rb#136
  def initialize(file_errors); end
end

# source://i18n//lib/i18n/exceptions.rb#135
I18n::InvalidFilenames::NUMBER_OF_ERRORS_SHOWN = T.let(T.unsafe(nil), Integer)

# source://i18n//lib/i18n/exceptions.rb#32
class I18n::InvalidLocale < ::I18n::ArgumentError
  # source://i18n//lib/i18n/exceptions.rb#34
  def initialize(locale); end

  # source://i18n//lib/i18n/exceptions.rb#33
  def locale; end
end

# source://i18n//lib/i18n/exceptions.rb#40
class I18n::InvalidLocaleData < ::I18n::ArgumentError
  # source://i18n//lib/i18n/exceptions.rb#42
  def initialize(filename, exception_message); end

  # source://i18n//lib/i18n/exceptions.rb#41
  def filename; end
end

# source://i18n//lib/i18n/exceptions.rb#92
class I18n::InvalidPluralizationData < ::I18n::ArgumentError
  # source://i18n//lib/i18n/exceptions.rb#94
  def initialize(entry, count, key); end

  # source://i18n//lib/i18n/exceptions.rb#93
  def count; end

  # source://i18n//lib/i18n/exceptions.rb#93
  def entry; end

  # source://i18n//lib/i18n/exceptions.rb#93
  def key; end
end

# source://i18n//lib/i18n/backend/key_value.rb#21
I18n::JSON = ActiveSupport::JSON

# source://i18n//lib/i18n/locale.rb#4
module I18n::Locale; end

# source://i18n//lib/i18n/locale/fallbacks.rb#48
class I18n::Locale::Fallbacks < ::Hash
  # source://i18n//lib/i18n/locale/fallbacks.rb#49
  def initialize(*mappings); end

  # source://i18n//lib/i18n/locale/fallbacks.rb#60
  def [](locale); end

  # source://i18n//lib/i18n/locale/fallbacks.rb#58
  def defaults; end

  # source://i18n//lib/i18n/locale/fallbacks.rb#55
  def defaults=(defaults); end

  # source://i18n//lib/i18n/locale/fallbacks.rb#82
  def empty?; end

  # source://i18n//lib/i18n/locale/fallbacks.rb#86
  def inspect; end

  # source://i18n//lib/i18n/locale/fallbacks.rb#67
  def map(*args, &block); end

  protected

  # source://i18n//lib/i18n/locale/fallbacks.rb#92
  def compute(tags, include_defaults = T.unsafe(nil), exclude = T.unsafe(nil)); end
end

# source://i18n//lib/i18n/locale/tag.rb#5
module I18n::Locale::Tag
  class << self
    # source://i18n//lib/i18n/locale/tag.rb#12
    def implementation; end

    # source://i18n//lib/i18n/locale/tag.rb#17
    def implementation=(implementation); end

    # source://i18n//lib/i18n/locale/tag.rb#22
    def tag(tag); end
  end
end

# source://i18n//lib/i18n/locale/tag/parents.rb#4
module I18n::Locale::Tag::Parents
  # source://i18n//lib/i18n/locale/tag/parents.rb#5
  def parent; end

  # source://i18n//lib/i18n/locale/tag/parents.rb#18
  def parents; end

  # source://i18n//lib/i18n/locale/tag/parents.rb#14
  def self_and_parents; end
end

# source://i18n//lib/i18n/locale/tag/rfc4646.rb#12
I18n::Locale::Tag::RFC4646_FORMATS = T.let(T.unsafe(nil), Hash)

# source://i18n//lib/i18n/locale/tag/rfc4646.rb#11
I18n::Locale::Tag::RFC4646_SUBTAGS = T.let(T.unsafe(nil), Array)

# source://i18n//lib/i18n/locale/tag/rfc4646.rb#14
class I18n::Locale::Tag::Rfc4646 < ::Struct
  include ::I18n::Locale::Tag::Parents

  # source://i18n//lib/i18n/locale/tag/rfc4646.rb#35
  def language; end

  # source://i18n//lib/i18n/locale/tag/rfc4646.rb#35
  def region; end

  # source://i18n//lib/i18n/locale/tag/rfc4646.rb#35
  def script; end

  # source://i18n//lib/i18n/locale/tag/rfc4646.rb#46
  def to_a; end

  # source://i18n//lib/i18n/locale/tag/rfc4646.rb#42
  def to_s; end

  # source://i18n//lib/i18n/locale/tag/rfc4646.rb#38
  def to_sym; end

  # source://i18n//lib/i18n/locale/tag/rfc4646.rb#35
  def variant; end

  class << self
    # source://i18n//lib/i18n/locale/tag/rfc4646.rb#23
    def parser; end

    # source://i18n//lib/i18n/locale/tag/rfc4646.rb#27
    def parser=(parser); end

    # source://i18n//lib/i18n/locale/tag/rfc4646.rb#18
    def tag(tag); end
  end
end

# source://i18n//lib/i18n/locale/tag/rfc4646.rb#50
module I18n::Locale::Tag::Rfc4646::Parser
  class << self
    # source://i18n//lib/i18n/locale/tag/rfc4646.rb#63
    def match(tag); end
  end
end

# source://i18n//lib/i18n/locale/tag/rfc4646.rb#51
I18n::Locale::Tag::Rfc4646::Parser::PATTERN = T.let(T.unsafe(nil), Regexp)

# source://i18n//lib/i18n/locale/tag/simple.rb#6
class I18n::Locale::Tag::Simple
  include ::I18n::Locale::Tag::Parents

  # source://i18n//lib/i18n/locale/tag/simple.rb#17
  def initialize(*tag); end

  # source://i18n//lib/i18n/locale/tag/simple.rb#21
  def subtags; end

  # source://i18n//lib/i18n/locale/tag/simple.rb#15
  def tag; end

  # source://i18n//lib/i18n/locale/tag/simple.rb#33
  def to_a; end

  # source://i18n//lib/i18n/locale/tag/simple.rb#29
  def to_s; end

  # source://i18n//lib/i18n/locale/tag/simple.rb#25
  def to_sym; end

  class << self
    # source://i18n//lib/i18n/locale/tag/simple.rb#8
    def tag(tag); end
  end
end

# source://i18n//lib/i18n/middleware.rb#4
class I18n::Middleware
  # source://i18n//lib/i18n/middleware.rb#6
  def initialize(app); end

  # source://i18n//lib/i18n/middleware.rb#10
  def call(env); end
end

# source://i18n//lib/i18n/exceptions.rb#100
class I18n::MissingInterpolationArgument < ::I18n::ArgumentError
  # source://i18n//lib/i18n/exceptions.rb#102
  def initialize(key, values, string); end

  # source://i18n//lib/i18n/exceptions.rb#101
  def key; end

  # source://i18n//lib/i18n/exceptions.rb#101
  def string; end

  # source://i18n//lib/i18n/exceptions.rb#101
  def values; end
end

# source://i18n//lib/i18n/exceptions.rb#48
class I18n::MissingTranslation < ::I18n::ArgumentError
  include ::I18n::MissingTranslation::Base
end

# source://i18n//lib/i18n/exceptions.rb#49
module I18n::MissingTranslation::Base
  # source://i18n//lib/i18n/exceptions.rb#54
  def initialize(locale, key, options = T.unsafe(nil)); end

  # source://i18n//lib/i18n/exceptions.rb#52
  def key; end

  # source://i18n//lib/i18n/exceptions.rb#59
  def keys; end

  # source://i18n//lib/i18n/exceptions.rb#52
  def locale; end

  # source://i18n//lib/i18n/exceptions.rb#65
  def message; end

  # source://i18n//lib/i18n/exceptions.rb#74
  def normalized_option(key); end

  # source://i18n//lib/i18n/exceptions.rb#52
  def options; end

  # source://i18n//lib/i18n/exceptions.rb#80
  def to_exception; end

  # source://i18n//lib/i18n/exceptions.rb#65
  def to_s; end
end

# source://i18n//lib/i18n/exceptions.rb#50
I18n::MissingTranslation::Base::PERMITTED_KEYS = T.let(T.unsafe(nil), Array)

# source://i18n//lib/i18n/exceptions.rb#88
class I18n::MissingTranslationData < ::I18n::ArgumentError
  include ::I18n::MissingTranslation::Base
end

# source://i18n//lib/i18n.rb#19
I18n::RESERVED_KEYS = T.let(T.unsafe(nil), Array)

# source://i18n//lib/i18n/exceptions.rb#108
class I18n::ReservedInterpolationKey < ::I18n::ArgumentError
  # source://i18n//lib/i18n/exceptions.rb#110
  def initialize(key, string); end

  # source://i18n//lib/i18n/exceptions.rb#109
  def key; end

  # source://i18n//lib/i18n/exceptions.rb#109
  def string; end
end

# source://i18n//lib/i18n/tests.rb#4
module I18n::Tests; end

# source://i18n//lib/i18n/tests/localization.rb#3
module I18n::Tests::Localization
  class << self
    # source://i18n//lib/i18n/tests/localization.rb#9
    def included(base); end
  end
end

# source://i18n//lib/i18n/exceptions.rb#116
class I18n::UnknownFileType < ::I18n::ArgumentError
  # source://i18n//lib/i18n/exceptions.rb#118
  def initialize(type, filename); end

  # source://i18n//lib/i18n/exceptions.rb#117
  def filename; end

  # source://i18n//lib/i18n/exceptions.rb#117
  def type; end
end

# source://i18n//lib/i18n/exceptions.rb#124
class I18n::UnsupportedMethod < ::I18n::ArgumentError
  # source://i18n//lib/i18n/exceptions.rb#126
  def initialize(method, backend_klass, msg); end

  # source://i18n//lib/i18n/exceptions.rb#125
  def backend_klass; end

  # source://i18n//lib/i18n/exceptions.rb#125
  def method; end

  # source://i18n//lib/i18n/exceptions.rb#125
  def msg; end
end

# source://i18n//lib/i18n/utils.rb#4
module I18n::Utils
  class << self
    # source://i18n//lib/i18n/utils.rb#18
    def deep_merge(hash, other_hash, &block); end

    # source://i18n//lib/i18n/utils.rb#22
    def deep_merge!(hash, other_hash, &block); end

    # source://i18n//lib/i18n/utils.rb#34
    def deep_symbolize_keys(hash); end

    # source://i18n//lib/i18n/utils.rb#7
    def except(hash, *keys); end

    private

    # source://i18n//lib/i18n/utils.rb#43
    def deep_symbolize_keys_in_object(value); end
  end
end

# source://i18n//lib/i18n/version.rb#4
I18n::VERSION = T.let(T.unsafe(nil), String)
