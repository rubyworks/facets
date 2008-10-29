require 'facets/string/lines'
require 'test/unit'

class TC_String_Lines < Test::Unit::TestCase

  def test_lines
    assert_equal( ['a','b','c'], "a\nb\nc".lines )
  end

end

