covers 'facets/module/method_clash'

test_case Module do

  setup do
    @x = Class.new do
      def q1; "q1"; end
      def x1; "x1"; end
      def r1; "r1"; end
      private
      def q2; "q2"; end
      def x2; "x1"; end
      protected
      def q3; "q3"; end
      def x3; "x3"; end
    end

    @y = Class.new do
      def q1; "q1"; end
      def y1; "y1"; end
      private
      def q2; "q2"; end
      def y2; "y2"; end
      def r1; "r1"; end
      protected
      def q3; "q3"; end
      def y3; "y3"; end
    end

    @z = Class.new
  end

  method :method_clash? do

    test do
      @x.assert.method_clash?(@y)
      @y.assert.method_clash?(@x)
      @z.refute.method_clash?(@x)
      @x.refute.method_clash?(@z)
    end

  end

  method :method_clash do

    test do
      c = @x.method_clash(@y)
      c.map!{ |m| m.to_s }
      %w{r1 q1 q2 q3}.each do |x|
        c.assert.include?(x)
      end
      %w{x1 x2 x3 y1 y2 y3}.each do |x|
        c.refute.include?(x)
      end
    end

  end

end
