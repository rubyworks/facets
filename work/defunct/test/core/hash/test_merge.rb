require 'facets/hash/merge'
require 'test/unit'

class TC_Hash_Merge < Test::Unit::TestCase

  def test_reverse_merge
    h1 = { :a=>1, :b=>2, :c=>2 }
    h2 = { :c=>3 }
    h3 = h1.reverse_merge(h2)
    assert_equal( 2, h3[:c] )
  end

end

