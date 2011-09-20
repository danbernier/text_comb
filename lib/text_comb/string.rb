require 'delegate'
require 'text_comb'

module TextComb
  module StringExtensions

    def words
      TextComb.words(self.to_s)
    end

    def sentences
      TextComb.sentences(self.to_s)
    end

    def ngrams(n, options={})
      TextComb.ngrams(self.to_s, n, options)
    end

    def guess_language
      TextComb.guess_language(self.to_s)
    end

  end

  class String < DelegateClass(::String)
    include StringExtensions
  end

  def self.string(s)
    TextComb::String.new(s)
  end

end
