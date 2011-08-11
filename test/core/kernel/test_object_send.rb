covers 'facets/kernel/object_send'

test_case Kernel do

  method :object_send do

    test "same as #public_send of Ruby 1.9+" do
      c = Class.new do
        def x; "x"; end
        private
        def y; "y"; end
      end

      o = c.new

      o.object_send(:x).assert == "x"

      expect NoMethodError do
        o.object_send(:y)
      end
    end

  end

end
