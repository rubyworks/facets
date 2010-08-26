require 'facets/string/each_char'
require 'test/unit'

class TC_String_Each_Char < Test::Unit::TestCase

  def test_each_char
    a = []
    i = "this"
    i.each_char{ |w| a << w }
    assert_equal( ['t', 'h', 'i', 's'], a )
  end

end

