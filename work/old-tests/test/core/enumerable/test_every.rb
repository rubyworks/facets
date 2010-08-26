require 'facets/enumerable/every'
require 'test/unit'

class TCEvery < Test::Unit::TestCase

  def test_every
    a = [1,2,3]
    assert_equal( [4,5,6], a.every + 3 )
    assert_equal( [0,1,2], a.every - 1 )
    assert_equal( ['1','2','3'], a.every.to_s )
  end

  def test_every!
    a = [1,2,3]
    a.every! + 3
    assert_equal( [4,5,6], a )
  end

  def test_to_enum_every
    e = [1,2,3].to_enum(:map)
    w = e.every + 3
    assert_equal( [4,5,6], w )
  end

end

