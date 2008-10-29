require 'facets/hash/keys'
require 'test/unit'

class TC_Hash_Keys < Test::Unit::TestCase

  def test_each_with_key
    h1 = { :a=>1, :b=>2 }
    h2 = {}
    h1.each_with_key { |v,k| h2[v] = k }
    assert_equal( {1=>:a, 2=>:b}, h2 )
  end

  def test_has_keys?
    assert( { :a=>1,:b=>2,:c=>3 }.has_keys?(:a,:b) )
    assert( ! { :a=>1,:b=>2,:c=>3 }.has_keys?(:a,:b,:d) )
  end

  def test_has_only_keys?
    assert( { :a=>1,:b=>2,:c=>3 }.has_only_keys?(:a,:b,:c) )
    assert( ! { :a=>1,:b=>2,:c=>3 }.has_only_keys?(:a,:b) )
  end

end

