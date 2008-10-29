require 'facets/string/chars'
require 'test/unit'

class TC_String_Chars < Test::Unit::TestCase

  def test_chars
    assert_equal( ["a","b","c"], "abc".chars )
    assert_equal( ["a","b","\n","c"], "ab\nc".chars )
  end

end

