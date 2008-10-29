require 'facets/string/variablize'
require 'test/unit'

class Test_String < Test::Unit::TestCase

  def test_variablize
    s = "a"
    assert_equal( "@a", s.variablize )
  end

end

