require 'facets/string/splice'
require 'test/unit'

class TC_String < Test::Unit::TestCase

  def test_splice
    a = "HELLO"
    assert_equal( "E", a.splice(1) )
    assert_equal( "HLLO", a )
  end

  # This could be done if class of 2nd arg is checked.
  #def test_splice_length
  #  a = "HELLO"
  #  assert_equal( "EL", a.splice(1,2) )
  #  assert_equal( "HLO", a )
  #end

  def test_splice_range
    a = "HELLO"
    assert_equal( "EL", a.splice(1..2) )
    assert_equal( "HLO", a )
  end

  def test_splice_store
    a = "HELLO"
    a.splice(1, "X")
    assert_equal("HXLLO", a)
  end

end

