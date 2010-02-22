require 'facets/unboundmethod/name'

class Test_UnboundMethod_Name < Test::Unit::TestCase

  class X
    def foo; "bar"; end
  end

  def test_name
    meth = X.instance_method(:foo)
    assert_equal(:foo, meth.name)
  end

end

