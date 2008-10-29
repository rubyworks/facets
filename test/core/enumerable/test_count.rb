require 'facets/enumerable/count'
require 'test/unit'

class TC_Enumerable_Count < Test::Unit::TestCase

  def test_count_01
    e = [ 'a', '1', 'a' ]
    assert_equal( 1, e.count('1') )
    assert_equal( 2, e.count('a') )
  end

  def test_count_02
    e = [ ['a',2], ['a',2], ['a',2], ['b',1] ]
    assert_equal( 3, e.count(['a',2]) )
  end

  def test_count_03
    e = { 'a' => 2, 'a' => 2, 'b' => 1 }
    assert_equal( 1, e.count('a',2) )
  end

end
