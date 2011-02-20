covers 'facets/kernel/object_state'

#tests Kernel do
#
#  unit :object_state do
#    c = Class.new do
#      def initialize(a,b)
#        @a, @b = a, b
#      end
#    end
#    o = c.new(1,2)
#    s = o.object_state
#    s.assert == {:a=>1, :b=>2}
#  end
#
#end

tests Object do

  unit :object_state do
    c = Class.new do
      def initialize(a,b)
        @a, @b = a, b
      end
    end
    o = c.new(1,2)
    s = o.object_state
    s.assert == {:a=>1, :b=>2}
  end

end

tests Struct do

  unit :object_state do
    c = Struct.new(:a, :b)
    o = c.new(1,2)
    s = o.object_state
    s.assert == {:a=>1, :b=>2}
  end

end

tests Array do

  unit :object_state do
    a = [1,2,3,4]
    s = a.object_state
    s.assert == a
  end

end

tests Hash do

  unit :object_state do
    h = {:a=>1,:b=>2,:c=>3}
    s = h.object_state
    s.assert == h
  end

end

tests String do

  unit :object_state do
    t = "test string"
    s = t.object_state
    s.assert == t
  end

end
