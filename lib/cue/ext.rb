require 'delegate'

module Cue
  module StringExtensions
    def each_word(&block)
      if block_given?
        Cue.each_word(self.to_s, &block)
      else
        to_enum(:each_word)
      end
    end

    def each_sentence(&block)
      if block_given?
        Cue.each_sentence(self.to_s, &block)
      else
        to_enum(:each_sentence)
      end
    end

    def each_ngram(n, &block)
      if block_given?
        Cue.each_ngram(self.to_s, n, &block)
      else
        to_enum(:each_ngram, n)
      end
    end
    
  end

  class String < DelegateClass(::String)
    include StringExtensions
  end
end
