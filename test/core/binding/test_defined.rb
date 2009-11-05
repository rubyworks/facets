require 'facets/binding/defined'
require 'test/unit'

class TC_Binding_Defined < Test::Unit::TestCase

  def setup
    a = 1
    b = 2
    x = "hello"
    @bind = binding
  end

  def test_defined?
    assert( @bind.defined?("x") )
  end

end

