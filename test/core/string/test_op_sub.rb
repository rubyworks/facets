require 'facets/string/op_sub'
require 'test/unit'

class Test_String < Test::Unit::TestCase

  def test_op_sub
    s = "xxbooxxfoo"
    assert_equal( "boofoo", s - "xx" )
  end

end

