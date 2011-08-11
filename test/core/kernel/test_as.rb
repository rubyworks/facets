covers 'facets/kernel/as'

test_case Kernel do

  setup "class heirarchy" do
    a = Class.new do
      def x; "a.x"; end
      def y; "a.y"; end
    end
    b = Class.new(a) do
      def x; "b.x" end
      def y; "b.y" end
    end
    c = Class.new(b) do
      def x; "c.x"; end
      define_method(:y){ as(a).x }
    end
    @a, @b, @c = a, b, c
  end

  method :as do 

    test do
      o = @c.new
      o.x.assert == "c.x"
      o.y.assert == "a.x"
    end

  end

  method :send_as do

    test do
      s = "a"
      def s.class; nil; end
      s.class.refute == String
      s.send_as(Object, :class).assert == String
    end

  end

  #setup "class heirarchy" do
  #  x = Class.new{ def x ; 1 ; end }
  #  y = Class.new(x){ def x ; 2 ; end }
  #  z = Class.new(y){ define_method(:x){ super_as(x) } }
  #  z
  #end

  #method :super_as do |z|
  #  o = z.new
  #  o.x.assert == 1
  #end

end

test_case As do

  class_method :new do

    setup do
      @c = Class.new(String) do
             def to_s; "denied"; end
           end
    end

    test do
      o = @c.new("hi")
      o.to_s.assert == "denied"
      As.new(o, String).to_s.assert == "hi"
    end

  end

end
