Covers 'facets/unboundmethod/name'

Case UnboundMethod do

  class X
    def foo; "bar"; end
  end

  Unit :name do
    meth = X.instance_method(:foo)
    meth.name.to_sym.assert == :foo
  end

end

