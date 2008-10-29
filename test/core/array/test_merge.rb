require 'facets/array/merge'
require 'test/unit'

class TC_Array_Merge < Test::Unit::TestCase

  # merge

  def test_merge
    a = [1,2,3]
    b = [3,4,5]
    assert_equal( [1,2,3,4,5], a.merge(b) )
  end

  def test_merge!
    a = [1,2,3]
    b = [3,4,5]
    a.merge!(b)
    assert_equal( [1,2,3,4,5], a )
  end

end

