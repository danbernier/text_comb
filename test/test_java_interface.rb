require 'minitest/autorun'
require 'cue'

class TestJavaInterface < MiniTest::Unit::TestCase

  LITTANY = "
    I must not fear.  Fear is the mind-killer.  Fear is the little-death
    that brings total obliteration.  I will face my fear.  I will permit
    it to pass over me and through me.  And when it has gone past I will
    turn the inner eye to see its path.  Where the fear has gone there
    will be nothing.  Only I will remain.".strip

  def test_each_word
    expected = %w[I must not fear]

    assert_equal expected, Cue.words("I must not fear. ").to_a

    Cue.words("I must not fear. ") do |word|
      assert_equal expected.shift, word
    end
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

    assert_equal expected, Cue.sentences(LITTANY).to_a

    Cue.sentences(LITTANY) do |s|
      assert_equal expected.shift, s
    end
  end

  def test_each_ngram
    expected = ["I must", "must not", "not fear"]

    assert_equal expected, Cue.ngrams("I must not fear. ", 2).to_a

    Cue.ngrams("I must not fear. ", 2) do |ngram|
      assert_equal expected.shift, ngram
    end
  end

  def test_each_ngram_with_stop_words
    text = "Fear is the little-death that brings total obliteration."
    expected = ["brings total obliteration"]
    ngrams = Cue.ngrams(text, 3, :stop_words => :English).to_a

    assert_equal expected, ngrams
  end
end
