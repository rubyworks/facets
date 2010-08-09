require 'facets/string/to_re'
require 'test/unit'

class TestStringToRe < Test::Unit::TestCase

  def test_to_re
    assert_equal( /abc/, "abc".to_re )
    assert_equal( /a+bc/, "a+bc".to_re )
    assert_equal( /a+bc/, "a+bc".to_re(false) )
    assert_equal( /a\+bc/, "a+bc".to_re(true) )
  end

  def test_to_rx
    assert_equal( /abc/, "abc".to_rx )
    assert_equal( /a\+bc/, "a+bc".to_rx )
    assert_equal( /a+bc/, "a+bc".to_rx(false) )
    assert_equal( /a\+bc/, "a+bc".to_rx(true) )
  end

  def test_to_rx2
    a = "?"
    b = /#{a.to_rx}/
    assert( b =~ "?" )
  end

end

