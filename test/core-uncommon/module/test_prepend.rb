covers 'facets/module/prepend'

test_case Module do

  method :prepend  do

    test do
      m = Module.new do
        def q; "qm"; end
      end

      n = Module.new do
        def q; "qn"; end
        prepend m
      end

      x = Class.new do
        include n
      end

      x.new.q.assert == "qm"
    end

  end

end
