require 'test/unit'

class TC_Facets_Require < Test::Unit::TestCase

  def test_require_facets
    assert_nothing_raised{ require 'facets' }
  end

end
