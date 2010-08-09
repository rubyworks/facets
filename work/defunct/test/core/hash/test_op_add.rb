require 'facets/hash/op_add'
require 'test/unit'

class TC_Hash_Op < Test::Unit::TestCase

  def test_op_and
    a = { :a => 1, :b => 2 }
    b = { :b => 3, :c => 4 }
    r = { :a => 1, :b => 3, :c => 4 }
    assert_equal( r, a + b )
  end

end

