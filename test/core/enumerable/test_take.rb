require 'facets/enumerable/take'
require 'test/unit'

class TC_Enumerable_Defer < Test::Unit::TestCase

  SOURCE = (1..1/0.0)   # infinite Enumerable object

  def test_finite
    assert_equal [1,2,3,4,5], SOURCE.take(5)
  end

end

