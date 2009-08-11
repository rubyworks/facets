require 'facets/enumerable/per'
require 'test/unit'

class TCPer < Test::Unit::TestCase

  def test_per
    e = [1,2,3].per.map
    assert_equal( [4,5,6], e + 3 )
    assert_equal( [0,1,2], e - 1 )
  end

  def test_per_again
    e = [1,2,3].per.map
    assert_equal( ['1','2','3'], e.to_s )
  end

end

