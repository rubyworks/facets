covers 'facets/module/revise'

test_case Module do

  method :revisal do

    test do
      m = Module.new do
        def x ; 1 ; end
      end

      c = Class.new do
        include m.revisal {
          rename :y, :x
        }
      end

      ic = c.new

      ic.y.assert == 1
      NoMethodError.assert.raised?{ ic.x }
    end

  end

  method :revise do

    test do
      m = Module.new do
        def x ; 1 ; end
      end

      c = Class.new do
        include m.revise {
          rename :y, :x
        }
      end

      ic = c.new

      ic.y.assert == 1
      NoMethodError.assert.raised?{ ic.x }
    end

  end

  method :remove do

    test do
      c = Class.new do
        def the_removed_method ; 'not here' ; end
        remove :the_removed_method
      end

      c.new.refute.respond_to?(:the_removed_method)
    end

  end

end

