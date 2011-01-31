covers 'facets/unboundmethod/arguments'

tests UnboundMethod do

  x = Class.new do
    def foo(a, b); end
    def bar(a, b=1); end
  end

  unit :arguments do
    foomethod = x.instance_method(:foo)
    arguments  = foomethod.arguments
    arguments.assert == "a0, a1"

    barmethod = x.instance_method(:bar)
    arguments = barmethod.arguments
    arguments.assert == "a0, *args"
  end

end

