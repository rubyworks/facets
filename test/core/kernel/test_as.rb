Covers 'facets/kernel/as'

Case Kernel do

  #Context "class heirarchy" do
  #  x = Class.new{ def x ; 1 ; end }
  #  y = Class.new(x){ def x ; 2 ; end }
  #  z = Class.new(y){ define_method(:x){ super_as(x) } }
  #  z
  #end

  #unit :super_as do |z|
  #  o = z.new
  #  o.x.assert == 1
  #end

  Context "class heirarchy" do
    q1 = Class.new{ def x ; 1 ; end }
    q2 = Class.new(q1){ def x ; 2 ; end }
    q3 = Class.new(q2){ def x ; 3 ; end }
    [q1,q2,q3]
  end

  Unit :super_method do |q1,q2,q3|
    x = q1.new
    z = q3.new
    s0 = x.method(:x)
    s1 = z.super_method(q1, :x)
    s1.call.assert == s0.call
  end

  Context "class heirarchy" do
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
  end

  Unit :as do |c|
    o = c.new
    o.x.assert == "c.x"
    o.y.assert == "a.x"
  end

  Unit :send_as do
    s = "a"
    def s.class; nil; end
    s.class.refute == String
    s.send_as(Object, :class).assert == String
  end

end

