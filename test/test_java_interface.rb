require 'cue'

class TestJavaInterface < Test::Unit::TestCase

  def littany_against_fear
    "I must not fear.  Fear is the mind-killer.  Fear is the little-death
     that brings total obliteration.  I will face my fear.  I will permit
     it to pass over me and through me.  And when it has gone past I will
     turn the inner eye to see its path.  Where the fear has gone there
     will be nothing.  Only I will remain."
  end

  def test_each_word_with_block
    words = []
    Cue.each_word("I must not fear. ") { |word| words.push word }

    expected_words = %w[I must not fear]

    expected_words.zip(words).each do |expected, actual|
      assert_equal expected, actual
    end
  end

  def test_each_word_without_block
    words = Cue.each_word("I must not fear. ")

    expected_words = %w[I must not fear]

    expected_words.zip(words.to_a).each do |actual, expected|
      assert_equal expected, actual
    end
  end

  def test_each_sentence_with_block
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

  def test_each_sentence_without_block
    sentences = Cue.each_sentence(littany_against_fear)

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

    expected_sentences.zip(sentences.to_a).each do |expected, actual|
      assert_equal expected, actual
    end
  end

  def test_each_ngram_with_block
    ngrams = []
    Cue.each_ngram("I must not fear. ", 2) { |ngram| ngrams.push ngram }

    assert_equal "I must", ngrams.shift
    assert_equal "must not", ngrams.shift
    assert_equal "not fear", ngrams.shift
  end

  def test_each_ngram_without_block
    ngrams = Cue.each_ngram("I must not fear. ", 2).to_a

    assert_equal "I must", ngrams.shift
    assert_equal "must not", ngrams.shift
    assert_equal "not fear", ngrams.shift
  end
end
