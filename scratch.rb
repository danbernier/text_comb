require 'java'
require 'bin/cue.language.jar'

# The default way to reference classes
# (unless their root package is java, javax, org, or com)
Java::CueLangStop::StopWords
Java::CueLang::SentenceIterator

# This lets us reference cue classes as cue.lang.SentenceIterator,
# rather than Java::CueLang::SentenceIterator.
def cue
  Java::Cue
end

# Static enums look like Ruby constants.
cue.lang.stop.StopWords::English
cue.lang.stop.StopWords::Custom
cue.lang.stop.StopWords::Armenian
cue.lang.stop.StopWords::French
# etc.



i = cue.lang.NGramIterator.new(5, '')

def ngrams(n, txt, stopwords=nil)
  default_locale = java.util.Locale.default 
  i = cue.lang.NGramIterator.new(n, txt, default_locale, stopwords)
  res = []
  while i.has_next
    res.push i.next
  end
  return res
end

def guess_stop_words(text)
  # static method: StopWords.guess()
  cue.lang.stop.StopWords.guess(text)
end

#for (final String word : new SentenceIterator(hound, Locale.ENGLISH)) {
#    System.out.println(word);
#}
def sentences(text)
  i = cue.lang.SentenceIterator(text, java.util.Locale::ENGLISH)
  
end
