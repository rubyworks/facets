require 'facets/succ.rb'
require 'test/unit'

class TestStringSucc < Test::Unit::TestCase

  def test_succ
    assert_equal( "b", "a".succ )
    assert_equal( "b", "a".succ(1) )
    assert_equal( "c", "a".succ(2) )
    assert_equal( "d", "a".succ(3) )
  end

end

class TestNumericSucc < Test::Unit::TestCase

  def test_pred
    assert_equal(  3,  4.pred )
    assert_equal( -3, -2.pred )
    assert_equal(  2,  4.pred(2) )
    assert_equal( -4, -2.pred(2) )
    assert_equal(  6,  4.pred(-2) )
    assert_equal(  0, -2.pred(-2) )
  end

  def test_succ
    assert_equal(  5,  4.succ )
    assert_equal( -1, -2.succ )
    assert_equal(  6,  4.succ(2) )
    assert_equal(  0, -2.succ(2) )
    assert_equal(  2,  4.succ(-2) )
    assert_equal( -4, -2.succ(-2) )
  end

end
