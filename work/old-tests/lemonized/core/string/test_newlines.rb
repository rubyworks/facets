require 'facets/string/newlines'
require 'test/unit'

class TC_String_NewLines < Test::Unit::TestCase

  # Since Ruby 1.9 defined #lines to keep the newline character,
  # we have defined #newlines to leave them out.
  def test_newlines
    assert_equal( ["a","b","c"], "a\nb\nc".newlines.to_a )
  end

end

