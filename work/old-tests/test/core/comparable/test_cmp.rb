require 'facets/comparable/cmp.rb'
require 'test/unit'

class TestComparable < Test::Unit::TestCase

  def test_cmp
    assert_equal( -1, 3.cmp(4) )
    assert_equal(  0, 3.cmp(3) )
    assert_equal(  1, 3.cmp(2) )
  end

end

class TestNumericCompare < Test::Unit::TestCase

  def test_cmp
    assert_equal( -1, 3.cmp(4) )
    assert_equal(  0, 3.cmp(3) )
    assert_equal(  1, 3.cmp(2) )
  end

end

class TestStringCompare < Test::Unit::TestCase

  def test_cmp
    assert_equal( 0, "abc".cmp("abc") )
    assert_equal( -1, "abc".cmp("abcd") )
    assert_equal( 1, "abcd".cmp("abc") )
    assert_equal( -1, "abc".cmp("bcd") )
    assert_equal( 1, "bcd".cmp("abc") )
  end

end

