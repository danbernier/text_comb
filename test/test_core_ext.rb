require 'minitest/autorun'
require 'textcomb'

class TestExtendingStringClass < MiniTest::Unit::TestCase
  def test_that_all_strings_have_textcomb_methods

    # Don't run this until it's needed - it'll pollute other tests.
    require 'textcomb/core_ext'

    [:words, :sentences, :ngrams].each do |method|
      assert "some string".respond_to?(method)
    end
  end
end
