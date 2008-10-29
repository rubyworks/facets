# Test lib/more/add/facets/compare_on.rb

require 'facets/comparable/comparable.rb'
require 'test/unit'

class TestModuleCompare < Test::Unit::TestCase

  def test_comparable_with_arguments
    c = Class.new
    c.class_eval {
      include Comparable(:a,:b)
      attr_accessor :a, :b
      def initialize(a,b)
        @a=a; @b=b
      end
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

=begin
  def test_sort_on_old
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

