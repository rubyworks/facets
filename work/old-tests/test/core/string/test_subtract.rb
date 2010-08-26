require 'facets/string/subtract'
require 'test/unit'

class TC_String_Subtract < Test::Unit::TestCase

  def test_subtract
    assert_equal("fbar", "foobar" - "oo")
    assert_equal("pia pia!", "pizza pizza!" - "zz")
    assert_equal("", "letters" - /[a-z]+/)
  end

end

