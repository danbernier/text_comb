module Cue
  module StringExtensions
    def each_word
      Cue.each_word(self.to_s)
    end

    def each_sentence
      Cue.each_sentence(self.to_s)
    end

    def each_ngram(n)
      Cue.each_ngram(self.to_s, n)
    end
  end
end
