# frozen_string_literal: true

module TurkishRegexps
  # Let your regexps to speak in Turkish
  class TrRegexp
    # A new instance of TrRegexp
    #
    # @param [Regexp] pattern
    # @return [TrRegexp]
    def initialize(pattern)
      @source = pattern.source
      @options = pattern.options
      @casefold = pattern.casefold?
    end

    # Translate regexps into Turkish supported version
    #
    # @return [Regexp]
    def translate
      translate_matches
      add_meta_charset
      set_encoding
    end

    private

    attr_reader :source, :options, :casefold

    # Find character class inside regexp, then change them with an extended version
    #
    # @return [NilClass]
    def translate_matches
      char_class_re = /(.)-(.)/.freeze
      source.gsub!(char_class_re) { translate_range(*_1.split('-')) }
      nil
    end

    # Translate range of character class
    #
    # @param [String] first
    # @param [String] last
    # @return [String]
    def translate_range(first, last)
      (TurkishRanges::TrText.new(first)..TurkishRanges::TrText.new(last)).to_a.join \
        complement_range(first, last)
    end

    # Translate complement range of character class if regexp is case-insensitive
    #
    # @param [String] first
    # @param [String] last
    # @return [String]
    def complement_range(first, last)
      casefold ? (TurkishRanges::TrText.new(first.swapcase)..TurkishRanges::TrText.new(last.swapcase)).to_a.join : ''
    end

    # Expand meta characters to latin
    #
    # @return [NilClass]
    def add_meta_charset
      meta = { '\w' => '[\p{Latin}\d_]', '\W' => '[^\p{Latin}\d_]' }.freeze
      meta.each { source.gsub!(_1, _2) }
      nil
    end

    # Creates the last form of translated regexp, ready to use
    #
    # @return [Regexp]
    def set_encoding
      Regexp.new(source.force_encoding('UTF-8'), Regexp::FIXEDENCODING | options)
    end
  end
end
