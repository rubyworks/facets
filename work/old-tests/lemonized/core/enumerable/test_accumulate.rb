require 'facets/enumerable/accumulate'
require 'test/unit'

class TCAccumulate < Test::Unit::TestCase

  def test_accumulate
    a = [1,2,3]
    assert_equal( [2,3,4], a.accumulate.succ )
    assert_equal( ['2','3','4'], a.accumulate(2).succ.to_s )

    a = [{:ab=>1},{22=>:c}]
    assert_equal( [1,nil,nil,:c],a.accumulate.values_at(:ab,22) )
    assert_equal( ['a', 'b', '2','2'] ,a.accumulate(3).keys.to_s.split(//) )

    a = []
    assert_equal( [], a.accumulate.succ )
  end

end

