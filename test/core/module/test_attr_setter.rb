covers 'facets/module/attr_setter'

test_case Module do

  method :attr_setter do

    test do
      c = Class.new do
        attr_setter :a
      end
      x = c.new
      x.a(1)
      x.a.assert == 1
    end

    test do  
      c = Class.new do
        attr_setter :a
        alias_setter :b, :a
      end
      x = c.new
      x.b(1)
      x.a.assert == 1
    end

  end

end
