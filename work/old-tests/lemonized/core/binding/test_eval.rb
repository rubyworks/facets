require 'facets/binding/eval'
require 'test/unit'

class TC_Binding < Test::Unit::TestCase

  def setup
    x = "hello"
    @bind = binding
  end

  def test_eval
    assert_equal( "hello", @bind.eval("x") )
  end

end

