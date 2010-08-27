require 'facets/enumerable/modulate.rb'
require 'test/unit'

class Test_Enumerable_Modulate < Test::Unit::TestCase

  def test_compact_collect
    a = [2,4,6,8]
    r = a.modulate(2)
    x = [[2,6],[4,8]]
    assert_equal(x, r)
  end

end

