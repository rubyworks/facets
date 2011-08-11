covers 'facets/module/wrap_method'

test_case Module do

  method :wrap_method do

    test do
      c = Class.new do
        def a; "A"; end
        wrap_method(:a) { |old| old.call + "B" }
      end

      c.new.a.assert == "AB"
    end

  end

  method :wrap do

    test do
      c = Class.new do
        def b; "B"; end
        wrap(:b) { |old| old.call + "C" }
      end

      c.new.b.assert == "BC"
    end

  end

end

