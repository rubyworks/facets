covers 'facets/object/object_state'

test_case Object do
  method :object_state do
    test do
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
end

test_case Struct do
  method :object_state do
    test do
      c = Struct.new(:a, :b)
      o = c.new(1,2)
      s = o.object_state
      s.assert == {:a=>1, :b=>2}
    end
  end
end

test_case Array do
  method :object_state do
    test do
      a = [1,2,3,4]
      s = a.object_state
      s.assert == a
    end
  end
end

test_case Hash do
  method :object_state do
    test do
      h = {:a=>1,:b=>2,:c=>3}
      s = h.object_state
      s.assert == h
    end
  end
end

test_case String do
  method :object_state do
    test do
      t = "test string"
      s = t.object_state
      s.assert == t
    end
  end
end

#test_case Kernel do
#
#  method :object_state do
#    test do
#      c = Class.new do
#        def initialize(a,b)
#          @a, @b = a, b
#        end
#      end
#      o = c.new(1,2)
#      s = o.object_state
#      s.assert == {:a=>1, :b=>2}
#    end
#  end
#
#end

