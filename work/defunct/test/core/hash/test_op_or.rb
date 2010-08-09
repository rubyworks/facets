require 'facets/hash/op_or'
require 'test/unit'

class TC_Hash_Op < Test::Unit::TestCase

  def test_op_or
    a = { :a => 1, :b => 2 }
    b = { :b => 3 }
    r = { :a => 1, :b => 2 }
    assert_equal( r, a | b )
  end

end

