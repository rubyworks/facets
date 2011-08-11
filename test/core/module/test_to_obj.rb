covers 'facets/module/to_obj'

test_case Module do

  method :to_obj do

    test do
      m = Module.new do
        def x; "x"; end
        def y; "y"; end
      end
      o = m.to_obj
      o.x.assert == "x"
      o.y.assert == "y"
    end

  end

end

