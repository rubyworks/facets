covers 'facets/module/is'

tests Module do

  unit :is? do
    m = Module.new
    x = Class.new
    y = Class.new(x) do
      is m
    end

    y.assert.is?(x)
    y.assert.is?(m)
  end

  unit :is do
    m = Module.new do
      def q; "q"; end
    end
    x = Class.new do
      is m
    end
    x.new.q.assert == "q"
  end

  # Note, we dynamicall set the Self constant to avoid a named module
  # showing up as an uncovered namespace in the Lemon coverage report.

  unit :is do
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

