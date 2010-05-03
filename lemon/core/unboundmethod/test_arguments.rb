require 'facets/unboundmethod/arguments'

Case UnboundMethod do

  class X
    def foo(a, b); end
    def bar(a, b=1); end
  end

  Unit :arguments do
    foomethod = X.instance_method(:foo)
    arguments  = foomethod.arguments
    arguments.assert == "a0, a1"

    barmethod = X.instance_method(:bar)
    arguments = barmethod.arguments
    arguments.assert == "a0, *args"
  end

end

