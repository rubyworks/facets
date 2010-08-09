require 'facets/hash/dearray_values'
require 'test/unit'

class TestHashDearrayValues < Test::Unit::TestCase

  def test_dearray_values
    h = { :a=>[1], :b=>[1,2], :c=>3, :d=>[] }
    x = { :a=>1, :b=>1, :c=>3, :d=>nil }
    assert_equal(x, h.dearray_values)    
  end
  
  def test_dearray_singular_values
    h = { :a=>[1], :b=>[1,2], :c=>3, :d=>[] }
    x = { :a=>1, :b=>[1,2], :c=>3, :d=>nil }
    assert_equal(x, h.dearray_singular_values )
  end

end

