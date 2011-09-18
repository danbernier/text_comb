require 'java'
require_relative '../../bin/cue.language.jar'

module Textcomb

  def self.words(string)
    TextcombEnumerator.new(cue.WordIterator.new(string))
  end

  def self.sentences(string)
    TextcombEnumerator.new(cue.SentenceIterator.new(string))
  end

  # Textcomb.ngrams(string, 3)
  # Textcomb.ngrams(string, 3, :locale => java.util.Locale.default)
  # Textcomb.ngrams(string, 3, :stop_words => :guess)
  # Textcomb.ngrams(string, 3, :stop_words => :English)
  # Textcomb.ngrams(string, 3, Textcomb.guess_language(string))
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

    cue_ngram_iter = cue.NGramIterator.new(n, string, locale, stop_words_val)
    TextcombEnumerator.new(cue_ngram_iter)
  end

  # Textcomb.guess_language "How are you?"
  def self.guess_language(string)
    stop.StopWords.guess string
  end

  # Textcomb.stop_words :English
  # Textcomb.stop_words :French
  def self.stop_words(stopwords_symbol)
    stop.StopWords.const_get(stopwords_symbol)
  end

  private
  def self.cue
    Java::CueLang
  end

  def self.stop
    Java::CueLangStop
  end

  class TextcombEnumerator
    include Enumerable

    def initialize(java_iter)
      @java_iter = java_iter
    end

    def each
      while @java_iter.has_next
        yield @java_iter.next
      end
    end

  end
end
