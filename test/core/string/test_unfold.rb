require 'test/unit'
require 'facets/string/unfold'

class TC_String_Unfold < Test::Unit::TestCase

  def test_unfold
    str = "This is a test of\nparagraph folding."
    res = str.unfold
    exp = "This is a test of paragraph folding."
    assert_equal(exp, res)
  end

end

