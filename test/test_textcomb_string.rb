require 'minitest/autorun'
require 'text_comb/string'

class TestTextcombString < MiniTest::Unit::TestCase

  def test_can_call_normal_string_methods
    plain_string = "I came. I saw. I hacked."
    textcomb = Textcomb.string(plain_string)

    assert_equal plain_string.upcase, textcomb.upcase
    assert_equal plain_string.reverse, textcomb.reverse
    assert_equal plain_string.gsub(/i/i, "We"), textcomb.gsub(/i/i, "We")
  end

  def test_can_call_each_word
    textcomb = Textcomb.string("I came. I saw. I hacked.")
    expected = %w[I came I saw I hacked]

    assert_equal expected, textcomb.words.to_a
  end

  def test_can_call_each_sentence
    textcomb = Textcomb.string("I came. I saw. I hacked.")
    expected = ["I came. ", "I saw. ", "I hacked."]

    assert_equal expected, textcomb.sentences.to_a
  end

  def test_can_call_each_ngram
    textcomb = Textcomb.string("Never wake a sleeping cat.")
    expected = ["Never wake a", "wake a sleeping", "a sleeping cat"]

    assert_equal expected, textcomb.ngrams(3).to_a
  end

  def test_ngrams_with_stop_words
    textcomb = Textcomb.string("I saw red roosters at Willy's farm.")
    expected = ["saw red", "red roosters", "Willy's farm"]

    ngrams = textcomb.ngrams(2, :stop_words => :English).to_a
    assert_equal expected, ngrams
  end

  def test_can_guess_its_language
    textcomb = Textcomb.string("I ate all the peanuts, then threw them up.")
    assert_equal Textcomb.stop_words(:English), textcomb.guess_language

    textcomb = Textcomb.string("J'ai la moutarde dans ma moustache.")
    assert_equal Textcomb.stop_words(:French), textcomb.guess_language
  end
end
