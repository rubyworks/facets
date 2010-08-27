require 'facets/numeric/distance.rb'
require 'test/unit'

class TestNumericDistance < Test::Unit::TestCase

  def test_distance
    assert_equal( 4, 10.distance(6) )
    assert_equal( 2, 10.distance(8) )
    assert_equal( -2, 7.distance(9) )
  end

end

