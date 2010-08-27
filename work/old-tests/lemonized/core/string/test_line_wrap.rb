require 'facets/string/line_wrap'
require 'test/unit'

class TestStringLineWrap < Test::Unit::TestCase

  def test_line_wrap
    assert_equal "abc\n123\n", "abc123".line_wrap(3)
    assert_equal "abcd\n123\n", "abcd123".line_wrap(4)
  end

end

