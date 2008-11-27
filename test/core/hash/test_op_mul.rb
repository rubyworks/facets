require 'facets/hash/op_mul'
require 'test/unit'

class TC_Hash_Op < Test::Unit::TestCase

  def test_op_mul
    a = { :a => 1, :b => 2 }
    b = { :b => 3 }
    r = { :a => 1, :b => 2 }
    assert_equal( r, a * b )
  end

end

