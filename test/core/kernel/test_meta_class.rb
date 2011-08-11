covers 'facets/kernel/meta_class'

test_case Kernel do

  method :meta_class do

    test do
      x = Class.new
      m = (class << x; self; end)
      x.meta_class.assert == m
    end

    test "class_eval block on meta class" do
      c = Class.new
      c.meta_class do
        def foo; "foo"; end
      end
      c.foo.assert == "foo"
    end

  end

  method :metaclass do

    test do
      x = Class.new
      m = (class << x; self; end)
      x.metaclass.assert == m
    end

  end

end
