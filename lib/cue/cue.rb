require 'java'

# TODO Where should this REALLY go?
# TODO How to load cue.language.jar when you're a gem?
require '../bin/cue.language.jar'


module Cue
  
  def self.each_word(string)
    iter = Java::CueLang::WordIterator.new(string)
    
    while iter.has_next do
      yield iter.next
    end
  end

  def self.each_sentence(string)
    iter = Java::CueLang::SentenceIterator.new(string)
    
    while iter.has_next do
      yield iter.next
    end
  end

  # TODO allow for Locale, and custom StopWords
  def self.each_ngram(string, n)
    iter = Java::CueLang::NGramIterator.new(n, string)
    
    while iter.has_next do
      yield iter.next
    end
  end

  # TODO add StopWords.guess()

end
