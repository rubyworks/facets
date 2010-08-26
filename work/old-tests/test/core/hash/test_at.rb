require 'facets/hash/at'
require 'test/unit'

class TC_Hash_At < Test::Unit::TestCase

  def test_at
    h = { :a=>1, :b=>2 }
    assert_equal( 1, h.at(:a) )
    assert_equal( 2, h.at(:b) )
  end

end

