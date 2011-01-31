covers 'facets/unboundmethod/name'

tests UnboundMethod do

  x = Class.new do
    def foo; "bar"; end
  end

  unit :name do
    meth = x.instance_method(:foo)
    meth.name.to_sym.assert == :foo
  end

end

