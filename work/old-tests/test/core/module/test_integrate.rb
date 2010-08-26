require 'facets/module/integrate'
require 'test/unit'

class Test_Module_Integrate < Test::Unit::TestCase

  module M
    def x ; 1 ; end
  end

  class C
    integrate M do
      rename :y, :x
    end
  end

  def test_integrate
    c = C.new
    assert_raises( NoMethodError ) { c.x }
    assert_equal( 1, c.y )
  end

end

