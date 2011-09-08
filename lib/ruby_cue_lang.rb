require 'java'

# TODO Where should this REALLY go?
# TODO How to load cue.language.jar when you're a gem?
require '../bin/cue.language.jar'


module Cue
  
  # This lets us reference cue classes as cue.lang.SentenceIterator,
  # rather than Java::CueLang::SentenceIterator.
  def cue
    Java::Cue
  end
  private :cue

  def self.each_word(string)
    iter = cue.lang.WordIterator.new(string)
    
    while iter.has_next do
      yield iter.next
    end
  end

  def self.each_sentence(string)
    iter = cue.lang.SentenceIterator.new(string)
    
    while iter.has_next do
      yield iter.next
    end
  end

  def self.each_ngram(string, n)
    iter = cue.lang.NGramIterator.new(n, string)
    
    while iter.has_next do
      yield iter.next
    end
  end

end
