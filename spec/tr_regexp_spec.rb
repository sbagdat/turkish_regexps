# frozen_string_literal: true

RSpec.configure do |config|
  config.include TurkishRegexps
  include TurkishRegexps
end

RSpec.describe 'TrRegexp' do
  context '#new' do
    it 'creates an object' do
      expect(TrRegexp.new(/\w+/)).to_not be nil
    end
  end

  context '#translate' do
    it 'translates downcase single letter ranges' do
      expect(TrRegexp.new(/[a-z]/).translate).to eq(/[abcçdefgğhıijklmnoöpqrsştuüvwxyz]/)
      expect(TrRegexp.new(/[ç-ö]/).translate).to eq(/[çdefgğhıijklmnoö]/)
      expect(TrRegexp.new(/[ç-ö]/).translate).to eq(/[çdefgğhıijklmnoö]/)
    end

    it 'translates upcase single letter ranges' do
      expect(TrRegexp.new(/[A-Z]/).translate).to eq(/[ABCÇDEFGĞHIİJKLMNOÖPQRSŞTUÜVWXYZ]/)
      expect(TrRegexp.new(/[Ç-Ş]/).translate).to eq(/[ÇDEFGĞHIİJKLMNOÖPQRSŞ]/)
      expect(TrRegexp.new(/[D-Ü]/).translate).to eq(/[DEFGĞHIİJKLMNOÖPQRSŞTUÜ]/)
    end

    it 'translates multiple ranges' do
      expect(TrRegexp.new(/[A-Dd-e]/).translate).to    eq(/[ABCÇDde]/)
      expect(TrRegexp.new(/[Ç-Ş#!$ç-ş]/).translate).to eq(/[ÇDEFGĞHIİJKLMNOÖPQRSŞ#!$çdefgğhıijklmnoöpqrsş]/)
    end

    it 'translates meta character: \w ' do
      ts_regexp = TrRegexp.new(/\w+/).translate
      expect(Regexp.compile(ts_regexp).match('ABCÇDEFGĞHIİJKLMNOÖPQRSabcçdeğiş')[0])
        .to eq 'ABCÇDEFGĞHIİJKLMNOÖPQRSabcçdeğiş'
    end

    it 'translates meta character: \W ' do
      ts_regexp = TrRegexp.new(/\W+/).translate
      expect(Regexp.compile(ts_regexp).match('ABCÇDEFGĞHIİJKLMNOÖPQRSŞTUÜVWXYZ.+%')[0])
        .to eq '.+%'
    end

    it 'fixes encoding' do
      ts_regexp = TrRegexp.new(/\w+/).translate
      expect(Regexp.compile(ts_regexp).fixed_encoding?).to be true
    end
  end
end
