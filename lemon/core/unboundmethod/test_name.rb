require 'facets/unboundmethod/name'

Case UnboundMethod do

  class X
    def foo; "bar"; end
  end

  def test_name
    meth = X.instance_method(:foo)
    meth.name.to_sym.assert == :foo
  end

end

