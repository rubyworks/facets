require 'facets/string/end_with'
require 'test/unit'

class Test_String < Test::Unit::TestCase

  def test_end_with?
    s = "xxboo"
    assert( s.end_with?('boo') )
  end

end

