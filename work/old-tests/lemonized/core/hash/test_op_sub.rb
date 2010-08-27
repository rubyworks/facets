require 'facets/hash/op_sub'
require 'test/unit'

class TC_Hash_Op < Test::Unit::TestCase

  def test_op_sub_array
    a = { :a => 1, :b => 2, :c => 3 }
    b = [ :a ]
    e = { :b => 2, :c => 3 }
    assert_equal( e, a - b )
  end

  def test_op_sub_hash
    a = { :a => 1, :b => 2, :c => 3 }
    b = { :a => 1, :d => 4 }
    e = { :b => 2, :c => 3 }
    assert_equal( e, a - b )
  end

end

