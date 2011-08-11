covers 'facets/module/method_space'

test_case Class do

  method :method_space do

    test "via a block" do
      c = Class.new do
        def x; "x"; end
        method_space :s do
          def x; "sx"; end
        end
      end
      o = c.new
      o.x.assert == 'x'
      o.s.x.assert == 'sx'
    end

    test "via module" do
      M = Module.new do
        def x; "mx"; end
      end
      c = Class.new do
        def x; "x"; end
        method_space M
      end
      o = c.new
      o.x.assert == 'x'
      o.m.x.assert == 'mx'
    end

    test "instance method is not defined" do
      c = Class.new do
        method_space :s do
          def x; "sx"; end
        end
      end
      o = c.new
      expect(NoMethodError){ c.x }
    end

  end

  method :include_as do

    setup do
      m = Module.new do
        def x; "x"; end
        def y; @y; end
      end
      @c = Class.new do
        include_as :m => m
        def initialize
          @y = "y"
        end
      end
    end

    test "provides method space" do
      o = @c.new
      o.m.x.assert == "x"
    end

    test "has access to instance scope" do
      o = @c.new
      o.m.y.assert == "y"
    end

  end

end

