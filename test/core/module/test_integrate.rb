covers 'facets/module/integrate'

test_case Module do

  method :integrate do

    test do
      m = Module.new do
        def x ; 1 ; end
      end

      c = Class.new do
        integrate m do
          rename :y, :x
        end
      end

      ic = c.new

      NoMethodError.assert.raised?{ ic.x }

      ic.y.assert == 1
    end

  end

end

