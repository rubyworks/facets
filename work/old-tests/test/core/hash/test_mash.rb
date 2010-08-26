require 'facets/hash/mash'
require 'test/unit'

class TC_Hash_Mash < Test::Unit::TestCase

  def test_mash_inplace!
    a = { :a => 1, :b => 2, :c => 3 }
    e = { :a => 2, :b => 3, :c => 4 }
    a.mash!{ |k,v| { k => v+1 } }
    assert_equal( e, a )
  end

  def test_mash_inplace_again!
    h  = {:a=>1,:b=>2,:c=>3}
    h.mash!{ |k,v| [v, v*v] }
    assert_equal( {1=>1, 2=>4, 3=>9}, h )
  end

end

