# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `dry-inflector` gem.
# Please instead update this file by running `bin/tapioca gem dry-inflector`.

# source://dry-inflector//lib/dry/inflector.rb#3
module Dry
  class << self
    # source://dry-core/1.0.1/lib/dry/core.rb#52
    def Equalizer(*keys, **options); end

    # source://dry-types/1.7.2/lib/dry/types.rb#253
    def Types(*namespaces, default: T.unsafe(nil), **aliases); end
  end
end

# source://dry-inflector//lib/dry/inflector.rb#7
class Dry::Inflector
  # source://dry-inflector//lib/dry/inflector.rb#33
  def initialize(&blk); end

  # source://dry-inflector//lib/dry/inflector.rb#66
  def camelize(input); end

  # source://dry-inflector//lib/dry/inflector.rb#49
  def camelize_lower(input); end

  # source://dry-inflector//lib/dry/inflector.rb#66
  def camelize_upper(input); end

  # source://dry-inflector//lib/dry/inflector.rb#104
  def classify(input); end

  # source://dry-inflector//lib/dry/inflector.rb#88
  def constantize(input); end

  # source://dry-inflector//lib/dry/inflector.rb#120
  def dasherize(input); end

  # source://dry-inflector//lib/dry/inflector.rb#136
  def demodulize(input); end

  # source://dry-inflector//lib/dry/inflector.rb#175
  def foreign_key(input); end

  # source://dry-inflector//lib/dry/inflector.rb#153
  def humanize(input); end

  # source://dry-inflector//lib/dry/inflector.rb#308
  def inspect; end

  # source://dry-inflector//lib/dry/inflector.rb#195
  def ordinalize(number); end

  # source://dry-inflector//lib/dry/inflector.rb#223
  def pluralize(input); end

  # source://dry-inflector//lib/dry/inflector.rb#243
  def singularize(input); end

  # source://dry-inflector//lib/dry/inflector.rb#262
  def tableize(input); end

  # source://dry-inflector//lib/dry/inflector.rb#308
  def to_s; end

  # source://dry-inflector//lib/dry/inflector.rb#300
  def uncountable?(input); end

  # source://dry-inflector//lib/dry/inflector.rb#279
  def underscore(input); end

  private

  # source://dry-inflector//lib/dry/inflector.rb#323
  def inflections; end

  # source://dry-inflector//lib/dry/inflector.rb#327
  def internal_camelize(input, upper); end
end

# source://dry-inflector//lib/dry/inflector/acronyms.rb#9
class Dry::Inflector::Acronyms
  # source://dry-inflector//lib/dry/inflector/acronyms.rb#14
  def initialize; end

  # source://dry-inflector//lib/dry/inflector/acronyms.rb#27
  def add(rule, replacement); end

  # source://dry-inflector//lib/dry/inflector/acronyms.rb#21
  def apply_to(word, capitalize: T.unsafe(nil)); end

  # source://dry-inflector//lib/dry/inflector/acronyms.rb#10
  def regex; end

  private

  # source://dry-inflector//lib/dry/inflector/acronyms.rb#36
  def define_regex_patterns; end
end

# source://dry-inflector//lib/dry/inflector.rb#321
Dry::Inflector::DEFAULT_SEPARATOR = T.let(T.unsafe(nil), String)

# source://dry-inflector//lib/dry/inflector/inflections.rb#12
class Dry::Inflector::Inflections
  # source://dry-inflector//lib/dry/inflector/inflections.rb#76
  def initialize; end

  # source://dry-inflector//lib/dry/inflector/inflections.rb#197
  def acronym(*words); end

  # source://dry-inflector//lib/dry/inflector/inflections.rb#67
  def acronyms; end

  # source://dry-inflector//lib/dry/inflector/inflections.rb#224
  def human(rule, replacement); end

  # source://dry-inflector//lib/dry/inflector/inflections.rb#59
  def humans; end

  # source://dry-inflector//lib/dry/inflector/inflections.rb#151
  def irregular(singular, plural); end

  # source://dry-inflector//lib/dry/inflector/inflections.rb#105
  def plural(rule, replacement); end

  # source://dry-inflector//lib/dry/inflector/inflections.rb#35
  def plurals; end

  # source://dry-inflector//lib/dry/inflector/inflections.rb#128
  def singular(rule, replacement); end

  # source://dry-inflector//lib/dry/inflector/inflections.rb#43
  def singulars; end

  # source://dry-inflector//lib/dry/inflector/inflections.rb#175
  def uncountable(*words); end

  # source://dry-inflector//lib/dry/inflector/inflections.rb#51
  def uncountables; end

  private

  # source://dry-inflector//lib/dry/inflector/inflections.rb#239
  def add_irregular(rule, replacement, target); end

  # source://dry-inflector//lib/dry/inflector/inflections.rb#252
  def rule(rule, replacement, target); end

  class << self
    # source://dry-inflector//lib/dry/inflector/inflections.rb#22
    def build(&blk); end
  end
end

# source://dry-inflector//lib/dry/inflector/inflections/defaults.rb#12
module Dry::Inflector::Inflections::Defaults
  class << self
    # source://dry-inflector//lib/dry/inflector/inflections/defaults.rb#15
    def call(inflect); end

    private

    # source://dry-inflector//lib/dry/inflector/inflections/defaults.rb#112
    def acronyms(inflect); end

    # source://dry-inflector//lib/dry/inflector/inflections/defaults.rb#87
    def irregular(inflect); end

    # source://dry-inflector//lib/dry/inflector/inflections/defaults.rb#25
    def plural(inflect); end

    # source://dry-inflector//lib/dry/inflector/inflections/defaults.rb#55
    def singular(inflect); end

    # source://dry-inflector//lib/dry/inflector/inflections/defaults.rb#105
    def uncountable(inflect); end
  end
end

# source://dry-inflector//lib/dry/inflector.rb#317
Dry::Inflector::ORDINALIZE_TH = T.let(T.unsafe(nil), Hash)

# source://dry-inflector//lib/dry/inflector/rules.rb#9
class Dry::Inflector::Rules
  # source://dry-inflector//lib/dry/inflector/rules.rb#12
  def initialize; end

  # source://dry-inflector//lib/dry/inflector/rules.rb#18
  def apply_to(word); end

  # source://dry-inflector//lib/dry/inflector/rules.rb#32
  def each(&blk); end

  # source://dry-inflector//lib/dry/inflector/rules.rb#26
  def insert(index, array); end
end

# source://dry-inflector//lib/dry/inflector/version.rb#6
Dry::Inflector::VERSION = T.let(T.unsafe(nil), String)
