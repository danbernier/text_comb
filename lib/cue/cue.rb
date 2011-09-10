require 'java'

# TODO Where should this REALLY go?
# TODO How to load cue.language.jar when you're a gem?
require '../bin/cue.language.jar'


module Cue

  def self.each_word(string, &block)
    iter = CueEnumerator.new Java::CueLang::WordIterator.new(string)

    if block_given?
      iter.each &block
    else
      iter
    end
  end

  def self.each_sentence(string, &block)
    iter = CueEnumerator.new Java::CueLang::SentenceIterator.new(string)

    if block_given?
      iter.each &block
    else
      iter
    end
  end

  # TODO allow for Locale, and custom StopWords
  def self.each_ngram(string, n, &block)
    iter = CueEnumerator.new Java::CueLang::NGramIterator.new(n, string)

    if block_given?
      iter.each &block
    else
      iter
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
