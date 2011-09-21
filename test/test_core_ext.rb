require 'minitest/autorun'

class TestExtendingStringClass < MiniTest::Unit::TestCase
  def test_that_all_strings_have_textcomb_methods

    # Don't run this until it's needed - it'll pollute other tests.
    require 'text_comb/core_ext'

    [:words, :sentences, :ngrams].each do |method|
      assert "some string".respond_to?(method)
    end
  end
end
