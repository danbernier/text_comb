require 'java'

# TODO Where should this REALLY go?
# TODO How to load cue.language.jar when you're a gem?
require '../bin/cue.language.jar'


module Cue

  def self.each_word(string, &block)
    iterate Java::CueLang::WordIterator.new(string), &block
  end

  def self.each_sentence(string, &block)
    iterate Java::CueLang::SentenceIterator.new(string), &block
  end

  # Cue.each_ngram(string, 3)
  # Cue.each_ngram(string, 3, :locale => java.util.Locale.default)
  # Cue.each_ngram(string, 3, :stop_words => :guess)
  # Cue.each_ngram(string, 3, :stop_words => :English)
  # Cue.each_ngram(string, 3, Cue.guess_language(string))
  def self.each_ngram(string, n, options={}, &block)

    locale = options[:locale] || java.util.Locale.default

    stop_words_val = case options[:stop_words]
      when :guess then guess_language(string)
      when Symbol then stop_words(options[:stop_words])
      when Java::CueLangStop::StopWords then options[:stop_words]
      when nil then nil
      else raise "Can't recognize the stop_words: #{options[:stop_words]}"
    end

    ngram_iter = Java::CueLang::NGramIterator.new(n, string, locale, stop_words_val)
    iterate ngram_iter, &block
  end

  # Cue.guess_language "How are you?"
  def self.guess_language(string)
    Java::CueLangStop::StopWords.guess string
  end

  # Cue.stop_words :English
  # Cue.stop_words :French
  def self.stop_words(stopwords_symbol)
    Java::CueLangStop::StopWords.const_get(stopwords_symbol)
  end

  private
  def self.iterate(java_iter, &block)
    CueEnumerator.new(java_iter).tap do |enum|
      if block_given?
        enum.each &block
      else
        enum
      end
    end
  end

  class CueEnumerator
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
