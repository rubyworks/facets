require 'facets/unboundmethod/name'

class Test_UnboundMethod_Name < Test::Unit::TestCase

  class X
    def foo; end
  end

  def test_name
    meth = X.instance_method(:foo)
    assert_equal("foo", meth.name)
  end if RUBY_VERSION < "1.9" # UnboundMethod#name is defined already in 1.9.

end

