require 'facets/enumerable/none'
require 'test/unit'

class TC_Enumerable < Test::Unit::TestCase

  def test_none?
    a = [nil, nil]
    assert( a.none? )
    a = [false, false]
    assert( a.none? )
    a = [true, false]
    assert( ! a.none? )
    a = [nil, 1]
    assert( ! a.none? )
  end

end
