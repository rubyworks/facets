require 'facets/enumerable/occur'
require 'test/unit'

class TC_Enumerable_Occur < Test::Unit::TestCase

  def test_occur
    arr = [:a,:b,:a]
    assert_equal( [:b], arr.occur(1) )
    assert_equal( [:a], arr.occur(2) )
    assert_equal( [:b], arr.occur(1..1) )
    assert_equal( [:a], arr.occur{ |n| n % 2 == 0 } )
  end

end

