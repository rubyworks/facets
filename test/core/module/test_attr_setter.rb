covers 'facets/module/attr_setter'

tests Module do

  unit :attr_setter do
    c = Class.new do
      attr_setter :a
    end
    x = c.new
    x.a(1)
    x.a.assert == 1
  end

  unit :alias_setter do
    c = Class.new do
      attr_setter :a
      alias_setter :b, :a
    end
    x = c.new
    x.b(1)
    x.a.assert == 1
  end

end
