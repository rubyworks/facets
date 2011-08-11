covers 'facets/unboundmethod/arguments'

test_case UnboundMethod do

  method :arguments do

    test do
      x = Class.new do
        def foo(a, b); end
        def bar(a, b=1); end
      end

      foomethod = x.instance_method(:foo)
      arguments  = foomethod.arguments
      arguments.assert == "a0, a1"

      barmethod = x.instance_method(:bar)
      arguments = barmethod.arguments
      arguments.assert == "a0, *args"
    end

  end

end

