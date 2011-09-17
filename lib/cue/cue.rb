require 'java'
require_relative '../../bin/cue.language.jar'

module Cue

  def self.words(string)
    CueEnumerator.new(Java::CueLang::WordIterator.new(string))
  end

  def self.sentences(string)
    CueEnumerator.new(Java::CueLang::SentenceIterator.new(string))
  end

  # Cue.ngrams(string, 3)
  # Cue.ngrams(string, 3, :locale => java.util.Locale.default)
  # Cue.ngrams(string, 3, :stop_words => :guess)
  # Cue.ngrams(string, 3, :stop_words => :English)
  # Cue.ngrams(string, 3, Cue.guess_language(string))
  def self.ngrams(string, n, options={})

    locale = options[:locale] || java.util.Locale.default

    stop_words_val = case options[:stop_words]
      when :guess then guess_language(string)
      when Symbol then stop_words(options[:stop_words])
      when Java::CueLangStop::StopWords then options[:stop_words]
      when nil then nil
      else raise "Can't recognize the stop_words: #{options[:stop_words]}"
    end

    CueEnumerator.new(Java::CueLang::NGramIterator.new(n, string, locale, stop_words_val))
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
