require 'facets/string/chomp' # FIXME
require 'test/unit'

class Test_String < Test::Unit::TestCase

  def test_lchomp
    s = "xxboo"
    r = s.lchomp("xx")
    assert_equal( "boo", r )
  end

  def test_lchomp!
    s = "xxboo"
    s.lchomp!("xx")
    assert_equal( "boo", s )
  end

end
