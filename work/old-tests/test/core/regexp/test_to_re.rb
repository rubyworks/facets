require 'facets/regexp/to_re'
require 'test/unit'

class TestRegexpToRe < Test::Unit::TestCase

  def test_to_re
    r = /0..10/
    assert_equal( r, r.to_re )
  end

  def test_to_regexp
    r = /0..10/
    assert_equal( r, r.to_regexp )
  end

end

