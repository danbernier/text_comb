require 'minitest/autorun'
require 'text_comb'

class TestJavaInterface < MiniTest::Unit::TestCase

  LITTANY = "
    I must not fear.  Fear is the mind-killer.  Fear is the little-death
    that brings total obliteration.  I will face my fear.  I will permit
    it to pass over me and through me.  And when it has gone past I will
    turn the inner eye to see its path.  Where the fear has gone there
    will be nothing.  Only I will remain.".strip

  def test_each_word
    expected = %w[I must not fear]

    assert_equal expected, Textcomb.words("I must not fear. ").to_a
  end

  def test_each_sentence

    expected = [
      "I must not fear. ",
      "Fear is the mind-killer. ",
      "Fear is the little-death that brings total obliteration. ",
      "I will face my fear. ",
      "I will permit it to pass over me and through me. ",
      "And when it has gone past I will turn the inner eye to see its path. ",
      "Where the fear has gone there will be nothing. ",
      "Only I will remain."
    ]

    assert_equal expected, Textcomb.sentences(LITTANY).to_a
  end

  def test_each_ngram
    expected = ["I must", "must not", "not fear"]

    assert_equal expected, Textcomb.ngrams("I must not fear. ", 2).to_a
  end

  def test_each_ngram_with_stop_words
    text = "Fear is the little-death that brings total obliteration."
    expected = ["brings total obliteration"]
    ngrams = Textcomb.ngrams(text, 3, :stop_words => :English).to_a

    assert_equal expected, ngrams
  end
end
