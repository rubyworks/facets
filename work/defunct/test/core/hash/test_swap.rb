require 'facets/hash/swap.rb'
require 'test/unit'

class TestHashSwap < Test::Unit::TestCase

  def test_swap!
    h = { :a=>1, :b=>2 }
    assert_equal( { :a=>2, :b=>1 }, h.swap!(:a, :b) )
  end

end
