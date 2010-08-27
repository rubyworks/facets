require 'facets/hash/op_and'
require 'test/unit'

class TC_Hash_Op < Test::Unit::TestCase

  def test_op_and_hash
    a = { :a => 1, :b => 2 }
    b = { :a => 1 }
    r = { :a => 1 }
    assert_equal( r, a & b )
  end

  def test_op_and_hash_subarray
    a = { :a => [1], :b => [2] }
    b = { :a => [1] }
    r = { :a => [1] }
    assert_equal( r, a & b )
  end

  def test_op_and_array
    a = { :a => 1, :b => 2 }
    b = [ :a ]
    r = { :a => 1 }
    assert_equal( r, a & b )
  end

end

