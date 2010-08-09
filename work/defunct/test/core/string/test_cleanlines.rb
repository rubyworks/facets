require 'facets/string/cleanlines'
require 'test/unit'

class TC_String_CleanLines < Test::Unit::TestCase

  def test_cleanlines
    assert_equal( ["a","b","c"], "a \n b \nc".cleanlines.to_a )
  end

end

