# Test lib/more/ext/enumerable/elementwise.rb'

require 'facets/elementwise.rb'
require 'test/unit'

class TestElementWise < Test::Unit::TestCase

  def test_elementwise
    a = [1,2,3]
    b = [4,5]
    assert_equal( [4,5,6], a.elementwise + 3 )
    assert_equal( [5,7], a.elementwise + b )
    assert_equal( [[5,7],[3,4,5]], a.elementwise.+(b,2) )
    assert_equal( [[5,7],[4,5,6]], a.elementwise.+(b,3) )
  end

  def test_ewise
    a = [1,2,3]
    assert_equal( [4,5,6], a.ewise + 3 )
    assert_equal( [5,7], a.ewise + [4,5] )
    assert_equal( [[5,7],[3,4,5]], a.ewise.+([4,5],2) )
    assert_equal( [[5,7],[4,5,6]], a.ewise.+([4,5],3) )
  end

end
