require 'cue/ext'

class TestCueString < Test::Unit::TestCase

  def test_can_call_normal_String_methods
    plain_string = "I came. I saw. I hacked."
    cue_string = Cue::String.new(plain_string)

    assert_equal plain_string.upcase, cue_string.upcase
    assert_equal plain_string.reverse, cue_string.reverse
    assert_equal plain_string.gsub(/i/i, "We"), cue_string.gsub(/i/i, "We")
  end

  def test_can_call_each_word
    expected = %w[I came I saw I hacked]

    cuestr = Cue::String.new("I came. I saw. I hacked.")
    actual = cuestr.enum_for(:each_word).to_a

    assert_equal expected, actual
  end

  def test_can_call_each_sentence
    expected = ["I came. ", "I saw. ", "I hacked."]

    cuestr = Cue::String.new("I came. I saw. I hacked.")
    actual = cuestr.enum_for(:each_sentence).to_a

    assert_equal expected, actual
  end

  def test_can_call_each_ngram
    expected = ["Never wake a", "wake a sleeping", "a sleeping cat"]

    cuestr = Cue::String.new("Never wake a sleeping cat.")
    actual = []
    cuestr.each_ngram(3) { |ng| actual.push ng }

    assert_equal expected, actual
  end
end
