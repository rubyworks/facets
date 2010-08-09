require 'facets/string/mscan'
require 'test/unit'

class TC_String_MScan < Test::Unit::TestCase

  def test_mscan
    r = 'abc,def,gh'.mscan(/[,]/)
    assert( r.all?{ |md| MatchData === md } )
    assert_equal( 2, r.to_a.length )
    assert_equal( ',', r[0][0] )
    assert_equal( ',', r[1][0] )
  end

end

