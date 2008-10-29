require 'facets/string/bytes'
require 'test/unit'

class TC_String_Bytes < Test::Unit::TestCase

  def test_bytes
    s = "abc"
    assert_equal( s.unpack('C*'), s.bytes )
  end

end

