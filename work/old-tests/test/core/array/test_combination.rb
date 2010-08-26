require 'facets/array/combination'
require 'test/unit'

class TestEnumerableCombination < Test::Unit::TestCase

  def test_combination
    a = [1,2,3,4]
    z = a.combination(2).to_a
    r = [[1, 2], [1, 3], [1, 4], [2, 3], [2, 4], [3, 4]]
    assert_equal( r, z )
  end

  def test_combination_with_block
    r = []
    a = [1,2,3,4]
    a.combination(2){ |a,b| r << [a,b] }
    assert_equal( [[1,2],[1,3],[1,4],[2,3],[2,4],[3,4]], r )
  end

#   DEPRECATED
#   def test_each_unique_pair
#     r = []
#     a = [1,2,3,4]
#     a.each_unique_pair{ |a,b| r << [a,b] }
#     assert_equal( [[1,2],[1,3],[1,4],[2,3],[2,4],[3,4]], r )
#   end

end

