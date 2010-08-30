covers 'facets/comparable/op_get'

testcase Comparable do

  metaunit :[] do

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
  metaunit :sort_on do
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
=end

end

