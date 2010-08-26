require 'facets/enumerable/recursive'
require 'test/unit'

class TestEnumerableRecursive < Test::Unit::TestCase

  def test_each
    a = []
    [1,2,['a','b']].recursive.each{ |v| a << v }
    assert_equal([1,2,'a','b'], a)
  end

  def test_map
    a = [1,2,['a','b']].recursive.map{ |v| v.succ }
    assert_equal([2,3,['b','c']], a)
  end

end

