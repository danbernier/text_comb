require 'delegate'

module Cue
  module StringExtensions
    def words
      Cue.words(self.to_s)
    end

    def sentences
      Cue.sentences(self.to_s)
    end

    def ngrams(n, options={})
      Cue.ngrams(self.to_s, n, options)
    end

    def guess_language
      Cue.guess_language(self.to_s)
    end
    
  end

  class String < DelegateClass(::String)
    include StringExtensions
  end
end
