covers 'facets/kernel/as'

tests Kernel do

  #context "class heirarchy" do
  #  x = Class.new{ def x ; 1 ; end }
  #  y = Class.new(x){ def x ; 2 ; end }
  #  z = Class.new(y){ define_method(:x){ super_as(x) } }
  #  z
  #end

  #unit :super_as do |z|
  #  o = z.new
  #  o.x.assert == 1
  #end

  context "class heirarchy" do
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

  unit :as do |c|
    o = c.new
    o.x.assert == "c.x"
    o.y.assert == "a.x"
  end

  unit :send_as do
    s = "a"
    def s.class; nil; end
    s.class.refute == String
    s.send_as(Object, :class).assert == String
  end

end

tests As do

  c = Class.new(String) do
    def to_s; "denied"; end
  end

  meta :new do
    o = c.new("hi")
    o.to_s.assert == "denied"
    As.new(o, String).to_s.assert == "hi"
  end

end
