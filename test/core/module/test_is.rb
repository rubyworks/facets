covers 'facets/module/is'

test_case Module do

  method :is? do

    test do
      m = Module.new
      x = Class.new
      y = Class.new(x) do
        is m
      end

      y.assert.is?(x)
      y.assert.is?(m)
    end

  end

  method :is do

    test do
      m = Module.new do
        def q; "q"; end
      end
      x = Class.new do
        is m
      end
      x.new.q.assert == "q"
    end

    # Note, we dynamically set the Self constant to avoid a named module
    # showing up as an uncovered namespace in the Lemon coverage report.
    test do
      m = Module.new do
        s = Module.new do
          def q; "q"; end
        end
        const_set('Self', s)
      end
      x = Class.new do
        is m
      end
      x.q.assert == "q"
    end

  end

end

