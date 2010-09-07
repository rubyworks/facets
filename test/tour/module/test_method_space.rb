covers 'facets/module/method_space'

tests Class do

  unit :method_space => "via a block" do
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

  unit :method_space => "via module" do
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

  unit :method_space => "instance method is not defined" do
    c = Class.new do
      method_space :s do
        def x; "sx"; end
      end
    end
    o = c.new
    expect(NoMethodError){ c.x }
  end

  setup "using #include_as" do
    m = Module.new do
      def x; "x"; end
      def y; @y; end
    end
    c = Class.new do
      include_as :m => m
      def initialize
        @y = "y"
      end
    end
  end

  unit :include_as => "provides method space" do |c|
    o = c.new
    o.m.x.assert == "x"
  end

  unit :include_as => "has access to instance scope" do |c|
    o = c.new
    o.m.y.assert == "y"
  end

end

