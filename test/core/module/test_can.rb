covers 'facets/module/can'

test_case Module do

  method :can do

    test do
      m = Module.new do
        def x; "x"; end 
      end

      c = Class.new do
        can m
      end

      c.x.assert == "x"
    end

  end

end

