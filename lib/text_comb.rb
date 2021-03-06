require 'java'
require_relative '../vendor/cue.language.jar'
require_relative 'text_comb/string_extensions'
require_relative 'text_comb/string'
require_relative 'text_comb/iterator'

module TextComb

  def self.words(string)
    enumerate(cue.WordIterator.new(string))
  end

  def self.sentences(string)
    enumerate(cue.SentenceIterator.new(string))
  end

  # TextComb.ngrams(string, 3)
  # TextComb.ngrams(string, 3, :locale => java.util.Locale.default)
  # TextComb.ngrams(string, 3, :stop_words => :guess)
  # TextComb.ngrams(string, 3, :stop_words => :English)
  # TextComb.ngrams(string, 3, TextComb.guess_language(string))
  def self.ngrams(string, n, options={})

    locale = options[:locale] || java.util.Locale.default

    stop_words_val = case options[:stop_words]
      when :guess
        guess_language(string)
      when Symbol
        stop_words(options[:stop_words])
      when stop.StopWords
        options[:stop_words]
      when nil
        nil
      else
        raise "Can't recognize the stop_words: #{options[:stop_words]}"
    end

    enumerate(cue.NGramIterator.new(n, string, locale, stop_words_val))
  end

  # TextComb.guess_language "How are you?"
  def self.guess_language(string)
    stop.StopWords.guess(string)
  end

  # TextComb.stop_words :English
  # TextComb.stop_words :French
  def self.stop_words(stopwords_symbol)
    stop.StopWords.const_get(stopwords_symbol)
  end
  
  
  # For convenience
  def self.string(s)
    TextComb::String.new(s)
  end
  

  private
  def self.cue
    Java::CueLang
  end

  def self.stop
    Java::CueLangStop
  end

  def self.enumerate(iterator)
    Iterator.new(iterator)
  end
end
