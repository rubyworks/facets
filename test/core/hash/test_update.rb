require 'facets/hash/update'
require 'test/unit'

class TC_Hash_Prime < Test::Unit::TestCase

  def test_shift_update
    a = { :a => 1, :b => 2, :c => 3 }
    b = { :a => 0, :d => 4 }
    e = { :a => 0, :b => 2, :c => 3, :d => 4 }
    assert_equal( e, a << b )
  end

  def test_update_each
    a = { :a => 1, :b => 2, :c => 3 }
    e = { :a => 2, :b => 3, :c => 4 }
    a.update_each{ |k,v| { k => v+1 } }
    assert_equal( e, a )
  end

  def test_update_keys_01
    h = { 'A' => 1, 'B' => 2 }
    h.update_keys{ |k| k.downcase }
    assert_equal( { 'a' => 1, 'b' => 2 }, h)
  end

  def test_update_keys_02
    h = { :a => 1, :b => 2 }
    h.update_keys{ |k| "#{k}!" }
    assert_equal( { "a!" => 1, "b!" => 2 }, h)
  end

  def test_update_values
    h = { 1 => 'A', 2 => 'B' }
    h.update_values{ |v| v.downcase }
    assert_equal( { 1 => 'a', 2 => 'b' }, h )
  end

  def test_replace_each
    a = { :a => 1, :b => 2, :c => 3 }
    e = { :a => 2, :b => 3, :c => 4 }
    a.replace_each{ |k,v| { k => v+1 } }
    assert_equal( e, a )
  end

end

