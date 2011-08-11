covers 'facets/module/redefine_method'

test_case Module do

  method :redefine_method do

    test do
      c = Class.new do
        def a; "a"; end
        redefine_method(:a){ nil }
      end
      c.new.a.assert == nil
    end

  end

  method :redef do

    test do
      c = Class.new do
        def b; "b"; end
        redef(:b){ "x" }
      end
      c.new.b.assert == "x"
    end

  end

end

