covers 'facets/module/rename_method'

test_case Module do

  method :rename_method do

    test do
      c = Class.new do
        def a; "A" ; end
        rename_method :b, :a
      end

      c.new.refute.respond_to?(:a)
      c.new.assert.respond_to?(:b)
    end

  end

  method :rename do

    test do
      c = Class.new do
        def c; "C" ; end
        rename :d, :c
      end

      c.new.refute.respond_to?(:c)
      c.new.assert.respond_to?(:d)
    end

  end

end

