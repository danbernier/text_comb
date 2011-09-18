require 'delegate'
require 'textcomb'

module Textcomb
  module StringExtensions

    def words
      Textcomb.words(self.to_s)
    end

    def sentences
      Textcomb.sentences(self.to_s)
    end

    def ngrams(n, options={})
      Textcomb.ngrams(self.to_s, n, options)
    end

    def guess_language
      Textcomb.guess_language(self.to_s)
    end

  end

  class String < DelegateClass(::String)
    include StringExtensions
  end

  def self.string(s)
    Textcomb::String.new(s)
  end

end
