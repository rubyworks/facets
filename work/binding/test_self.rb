require 'facets/binding/self'
require 'test/unit'

class TC_Binding_Self < Test::Unit::TestCase

  def setup
    a = 1
    b = 2
    x = "hello"
    @bind = binding
  end

  def test_self
    assert_equal( self, @bind.self )
  end

end

