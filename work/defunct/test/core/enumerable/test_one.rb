require 'facets/enumerable/one'
require 'test/unit'

class TC_Enumerable < Test::Unit::TestCase

  def test_one?
    a = [nil, true]
    assert( a.one? )
    a = [true, false]
    assert( a.one? )
    a = [true, true]
    assert( ! a.one? )
    a = [true, 1]
    assert( ! a.one? )
    a = [1, 1]
    assert( ! a.one? )
  end

end
