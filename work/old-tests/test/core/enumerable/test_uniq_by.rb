require 'facets/enumerable/uniq_by'
require 'test/unit'

class TC_Enumerable_UniqBy < Test::Unit::TestCase

  def test_uniq_by
    a = [-5, -4, -3, -2, -1, 0]
    r = (-5..5).to_a.uniq_by{|i| i*i }
    assert_equal( a, r )
  end

end

