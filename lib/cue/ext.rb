require 'delegate'

module Cue
  module StringExtensions
    def each_word(&block)
      Cue.words(self.to_s, &block)
    end

    def each_sentence(&block)
      Cue.sentences(self.to_s, &block)
    end

    def each_ngram(n, options={}, &block)
      Cue.ngrams(self.to_s, n, options, &block)
    end
    
  end

  class String < DelegateClass(::String)
    include StringExtensions
  end
end
