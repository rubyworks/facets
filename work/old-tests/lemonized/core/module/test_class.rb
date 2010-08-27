require 'facets/module/class'
require 'test/unit'

class Test_Module_Class < Test::Unit::TestCase

  class X
  end

  class Y < X
  end

  def test_class?
    x = X.new
    y = Y.new
    assert( X.class?(x) )
    assert( Y.class?(y) )
    assert( Y.class?(y) )
  end

end

