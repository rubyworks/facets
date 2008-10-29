require 'facets/unboundmethod/arguments'

class Test_UnboundMethod  < Test::Unit::TestCase

  class X
    def foo(a, b); end
    def bar(a, b=1); end
  end

  def test_arguments
    foomethod = X.instance_method(:foo)
    arguments  = foomethod.arguments
    assert_equal( "a0, a1", arguments )

    barmethod = X.instance_method(:bar)
    arguments = barmethod.arguments
    assert_equal( "a0, *args", arguments )
  end

end

