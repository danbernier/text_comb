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

  # TODO allow for Locale, and custom StopWords
  def self.each_ngram(string, n, &block)
    iterate Java::CueLang::NGramIterator.new(n, string), &block
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

  # TODO add StopWords.guess()

end
