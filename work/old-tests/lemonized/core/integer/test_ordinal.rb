require 'test/unit'
require 'facets/integer/ordinal'

class TestIntegerOrdinal < Test::Unit::TestCase

  def test_ordinal
    assert_equal( '1st', 1.ordinal )
    assert_equal( '2nd', 2.ordinal )
    assert_equal( '3rd', 3.ordinal )
    assert_equal( '4th', 4.ordinal )
  end

end

