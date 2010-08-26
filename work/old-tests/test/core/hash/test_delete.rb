require 'facets/hash/delete'
require 'test/unit'

class TC_Hash_Delete < Test::Unit::TestCase

  def test_delete_unless
    a = { :a => 1, :b => 2, :c => 3 }
    e = { :a => 1 }
    r = a.delete_unless{|k,v| v == 1}
    assert_equal( e, a )
  end

  def test_delete_values
    a = { :a => 1, :b => 2, :c => 3 }
    e = { :b => 2, :c => 3 }
    r = a.delete_values(1)
    assert_equal( e, a )
  end

  def test_delete_values_at
    a = { :a => 1, :b => 2, :c => 3 }
    e = { :b => 2, :c => 3 }
    r = a.delete_values_at(:a)
    assert_equal( e, a )
  end

end

