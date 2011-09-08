require 'cue/ext'

module TestsForCueMethods
  def test_can_call_normal_string_methods
    plain_string = "I came. I saw. I hacked."
    cue_string = cue_string(plain_string)

    assert_equal plain_string.upcase, cue_string.upcase
    assert_equal plain_string.reverse, cue_string.reverse
    assert_equal plain_string.gsub(/i/i, "We"), cue_string.gsub(/i/i, "We")
  end

  def test_can_call_each_word
    cuestr = cue_string("I came. I saw. I hacked.")
    expected = %w[I came I saw I hacked]

    actual = cuestr.enum_for(:each_word).to_a

    assert_equal expected, actual
  end

  def test_can_call_each_sentence
    cuestr = cue_string("I came. I saw. I hacked.")
    expected = ["I came. ", "I saw. ", "I hacked."]

    actual = cuestr.enum_for(:each_sentence).to_a

    assert_equal expected, actual
  end

  def test_can_call_each_ngram
    cuestr = cue_string("Never wake a sleeping cat.")
    expected = ["Never wake a", "wake a sleeping", "a sleeping cat"]

    actual = []
    cuestr.each_ngram(3) { |ng| actual.push ng }

    assert_equal expected, actual
  end
end

class TestCueStringNew < Test::Unit::TestCase
  include TestsForCueMethods

  def cue_string(plain_string)
    Cue::String.new(plain_string)
  end
end

class TestManuallyExtendingAString < Test::Unit::TestCase
  include TestsForCueMethods

  def cue_string(plain_string)
    plain_string.extend(Cue::StringExtensions)
  end
end
