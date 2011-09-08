require 'ruby_cue_lang'

class TestJavaInterface < Test::Unit::TestCase
  def stray_birds
    "Stray birds of summer come to my window to sing and fly away.  And
     yellow leaves of autumn, which have no songs, flutter and fall there
     with a sigh.  O troupe of little vagrants of the world, leave your
     footprints in my words."
  end

  def stray_birds_short
    stray_birds.sub(/\..*/m, '')
  end

  def littany_against_fear
    "I must not fear.  Fear is the mind-killer.  Fear is the little-death
     that brings total obliteration.  I will face my fear.  I will permit
     it to pass over me and through me.  And when it has gone past I will
     turn the inner eye to see its path.  Where the fear has gone there
     will be nothing.  Only I will remain."
  end

  def test_each_word
    words = []
    Cue.each_word(stray_birds_short) { |word| words.push word }

    expected_words = %w[Stray birds of summer come to my window to sing and fly away]

    expected_words.zip(words).each do |expected, actual|
      assert_equal expected, actual
    end
  end

  def test_each_sentence
    sentences = []
    Cue.each_sentence(littany_against_fear) { |s| sentences.push s }

    expected_sentences = [
                          "I must not fear. ",
                          "Fear is the mind-killer. ",
                          "Fear is the little-death that brings total obliteration. ",
                          "I will face my fear. ",
                          "I will permit it to pass over me and through me. ",
                          "And when it has gone past I will turn the inner eye to see its path. ",
                          "Where the fear has gone there will be nothing. ",
                          "Only I will remain."
               ]

    expected_sentences.zip(sentences).each do |expected, actual|
      assert_equal expected, actual
    end
  end

  def test_each_ngram
    ngrams = []
    Cue.each_ngram("I must not fear", 2) { |ngram| ngrams.push ngram }

    assert_equal "I must", ngrams.shift
    assert_equal "must not", ngrams.shift
    assert_equal "not fear", ngrams.shift
  end
end
