require 'facets/integer/of'
require 'test/unit'

class TC_Integer_Of < Test::Unit::TestCase

  def test_of
    a = 4
    b = a.of{ |i| i*2 }
    assert_equal( [0,2,4,6], b )
  end

  def test_times_collect
    a = 4
    b = a.times_collect{ |i| i*2 }
    assert_equal( [0,2,4,6], b )
  end

end

