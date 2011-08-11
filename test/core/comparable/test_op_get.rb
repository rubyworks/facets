covers 'facets/comparable/op_get'

test_case Comparable do

  class_method :[] do

    test do
      c = Class.new do
        include Comparable[:a,:b]

        attr_accessor :a, :b

        def initialize(a,b)
          @a=a; @b=b
        end
      end

      a = [c.new(10,20),c.new(10,30)]
      a.sort.assert == a

      a = [c.new(10,30),c.new(10,20)]
      a.sort.assert == a.reverse

      a = [c.new(10,10),c.new(20,10)]
      a.sort.assert == a

      a = [c.new(20,10),c.new(10,10)]
      a.sort.assert == a.reverse

      a = [c.new(10,30),c.new(20,10)]
      a.sort.assert == a
    end

=begin
  class_method :sort_on do
    test do
      c = Class.new
      c.class_eval {
        def initialize(a,b)
          @a=a; @b=b
        end
        sort_on :a,:b
      }
      a = [c.new(10,20),c.new(10,30)]
      assert_equal( a, a.sort )
      a = [c.new(10,30),c.new(10,20)]
      assert_equal( a.reverse, a.sort )
      a = [c.new(10,10),c.new(20,10)]
      assert_equal( a, a.sort )
      a = [c.new(20,10),c.new(10,10)]
      assert_equal( a.reverse, a.sort )
      a = [c.new(10,30),c.new(20,10)]
      assert_equal( a, a.sort )
    end
  end
=end

  end

end

