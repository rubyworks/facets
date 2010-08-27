require 'facets/hash/op_push'
require 'test/unit'

class TC_Hash_Op < Test::Unit::TestCase

  def test_op_push_two_element_array
    h = {}
    a = [:b, 2]
    r = {:b => 2}
    assert_equal(h, h << a)
    assert_equal(r, h)
  end

  def test_op_push_hash
    h1 = {:a => 1}
    h2 = {:b => 2, :c => 3 }
    r = { :a => 1, :b => 2, :c => 3 }
    assert_equal(h1, h1 << h2)
    assert_equal(r, h1)
  end

  def test_shift_update
    a = { :a => 1, :b => 2, :c => 3 }
    b = { :a => 0, :d => 4 }
    e = { :a => 0, :b => 2, :c => 3, :d => 4 }
    assert_equal( e, a << b )
  end

end

