require 'facets/string/start_with'
require 'test/unit'

class Test_String < Test::Unit::TestCase

  def test_start_with?
    s = "xxboo"
    assert( s.start_with?('xx') )
  end

end

