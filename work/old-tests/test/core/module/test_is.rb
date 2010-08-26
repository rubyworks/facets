require 'test/unit'
require 'facets/module/is'

class Test_Module_Is < Test::Unit::TestCase

  module M ; end

  class X ; end
  class Y < X ; is M ;end

  def test_is?
    assert(Y.is?(X))
  end

  def test_is
    assert(Y.is?(M))
  end

end
