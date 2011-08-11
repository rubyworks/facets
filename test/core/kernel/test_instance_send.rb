covers 'facets/kernel/instance_send'

test_case Kernel do

  method :instance_send do

    test "alias for #send" do
      c = Class.new do
        def x; "x"; end
        private
        def y; "y"; end
      end

      o = c.new

      expect NoMethodError do
        o.y
      end

      o.instance_send(:x).assert == "x"
      o.instance_send(:y).assert == "y"
    end

  end

end
