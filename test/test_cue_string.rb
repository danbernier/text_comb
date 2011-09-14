require 'minitest/autorun'
require 'cue'

class TestCueString < MiniTest::Unit::TestCase

  def test_can_call_normal_string_methods
    plain_string = "I came. I saw. I hacked."
    cue_string = Cue::String.new(plain_string)

    assert_equal plain_string.upcase, cue_string.upcase
    assert_equal plain_string.reverse, cue_string.reverse
    assert_equal plain_string.gsub(/i/i, "We"), cue_string.gsub(/i/i, "We")
  end

  def test_can_call_each_word
    cuestr = Cue::String.new("I came. I saw. I hacked.")
    expected = %w[I came I saw I hacked]

    assert_equal expected, cuestr.words.to_a
  end

  def test_can_call_each_sentence
    cuestr = Cue::String.new("I came. I saw. I hacked.")
    expected = ["I came. ", "I saw. ", "I hacked."]

    assert_equal expected, cuestr.sentences.to_a
  end

  def test_can_call_each_ngram
    cuestr = Cue::String.new("Never wake a sleeping cat.")
    expected = ["Never wake a", "wake a sleeping", "a sleeping cat"]

    assert_equal expected, cuestr.ngrams(3).to_a
  end

  def test_ngrams_with_stop_words
    cuestr = Cue::String.new("I saw red roosters at Willy's farm.")
    expected = ["saw red", "red roosters", "Willy's farm"]

    ngrams = cuestr.ngrams(2, :stop_words => :English).to_a
    assert_equal expected, ngrams
  end

  def test_can_guess_its_language
    cuestr = Cue::String.new("I ate all the peanuts, then threw them up.")
    assert_equal Cue.stop_words(:English), cuestr.guess_language

    cuestr = Cue::String.new("J'ai la moutarde dans ma moustache.")
    assert_equal Cue.stop_words(:French), cuestr.guess_language
  end
end
