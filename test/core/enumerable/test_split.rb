require 'test/unit'
require 'facets/enumerable/split'

class Test_Enumerable_Split < Test::Unit::TestCase

  def test_empty
    assert_equal( [], [].split('a') )
  end

  def test_same
    assert_equal( [], ['a'].split('a') )
  end

  def test_split
    assert_equal( [['a'], ['c']], ['a','b','c'].split('b') )
  end

end

