require 'facets/range/to_r'
require 'test/unit'

class TestRangeConversion < Test::Unit::TestCase

  def test_to_r
    a = (0..10)
    assert_equal( a, a.to_r )
  end

  def test_to_range
    a = (0..10)
    assert_equal( a, a.to_range )
  end

end

