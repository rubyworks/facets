require 'facets/module/can'
require 'test/unit'

class Test_Module_Can < Test::Unit::TestCase

  module M 
    def x; "x"; end 
  end

  class X
    can M
  end

  def test_can
    assert("x", X.x)
  end

end

