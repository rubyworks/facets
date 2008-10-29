require 'facets/integer/multiple'
require 'test/unit'

class TC_Integer_Multiple < Test::Unit::TestCase

  def test_multiple?
    assert( ! 1.multiple?(2) )
    assert(   2.multiple?(2) )
    assert( ! 5.multiple?(3) )
    assert(   6.multiple?(3) )
  end

end

