require 'minitest/autorun'
require 'cue'

class TestExtendingStringClass < MiniTest::Unit::TestCase
  def test_that_all_strings_have_cue_methods

    # Don't run this until it's needed - it'll pollute other tests.
    require 'cue/core_ext'

    [:words, :sentences, :ngrams].each do |method|
      assert "some string".respond_to?(method)
    end
  end
end
