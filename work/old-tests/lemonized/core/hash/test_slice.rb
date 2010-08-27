require 'facets/hash/slice'
require 'test/unit'

class TC_Hash_Slice < Test::Unit::TestCase

  def test_slice
    h = {:a=>1,:b=>2,:c=>3}
    e = {:b=>2, :a=>1}
    assert_equal(e, h.slice(:a, :b))
  end

  def test_slice!
    h = {:a=>1,:b=>2,:c=>3}
    e = {:c=>3}
    assert_equal(e, h.slice!(:a, :b))
    assert_equal({:a=>1,:b=>2}, h)
  end

end

