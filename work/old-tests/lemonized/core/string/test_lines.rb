require 'facets/string/lines'
require 'test/unit'

class TC_String_Lines < Test::Unit::TestCase

  # Ruby 1.9 defined #lines to keep the newline character. Yuk!
  def test_lines
    assert_equal( ["a\n","b\n","c"], "a\nb\nc".lines.to_a )
  end

end

