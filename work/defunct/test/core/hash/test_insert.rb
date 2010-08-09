require 'facets/hash/insert'
require 'test/unit'

class TC_Hash_Prime < Test::Unit::TestCase

  def test_insert
    h = { :a=>1, :b=>2 }
    assert_equal( true  , h.insert(:c,3) )
    assert_equal( false , h.insert(:a,0) )
  end

end

