covers 'facets/unboundmethod/name'

test_case UnboundMethod do

  method :name do

    test do
      x = Class.new do
        def foo; "bar"; end
      end

      meth = x.instance_method(:foo)
      meth.name.to_sym.assert == :foo
    end

  end

end

