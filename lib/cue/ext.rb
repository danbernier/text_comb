require 'delegate'

module Cue
  module StringExtensions
    def each_word(&block)
      Cue.each_word(self.to_s, &block)
    end

    def each_sentence(&block)
      Cue.each_sentence(self.to_s, &block)
    end

    def each_ngram(n, &block)
      Cue.each_ngram(self.to_s, n, &block)
    end
  end

  class String < DelegateClass(::String)
    include StringExtensions
  end
end
