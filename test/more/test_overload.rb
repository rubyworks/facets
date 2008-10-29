# Test facets/overload.rb
require 'facets/overload.rb'
require 'test/unit'

#
#
class TC_Overload_01 < Test::Unit::TestCase

  class X

    def x
      "hello"
    end

    overload :x, Array do |x|
      [Array, x]
    end

    overload :x, Symbol do |x|
      [Symbol, x]
    end

  end

  def setup
    @x = X.new
  end

  def test_x
    assert_equal( "hello", @x.x )
  end

  def test_a
    assert_equal( [Array, [1]], @x.x([1]) )
  end

  def test_s
    assert_equal( [Symbol, :a], @x.x(:a) )
  end

end

#
#
class TC_Overload_02 < Test::Unit::TestCase

  class X

    def x
      "hello"
    end

    overload :x, Integer do |i|
      i
    end

    overload :x, String, String do |s1, s2|
      [s1, s2]
    end

  end

  def setup
    @x = X.new
  end

  def test_x
    assert_equal( "hello", @x.x )
  end

  def test_i
    assert_equal( 1, @x.x(1) )
  end

  def test_s
    assert_equal( ["a","b"], @x.x("a","b") )
  end

end

#
#
class TC_Overload_03 < Test::Unit::TestCase

  class SubArray < Array
  end

  class SubSubArray < SubArray
  end
  
  
  class X

    def x
      "hello"
    end

    overload :x, Integer do |i|
      i
    end
    
    overload :x, Symbol do |s|
      s
    end
    
    overload :x, String, String do |s1, s2|
      [s1, s2]
    end

    overload :x, Symbol, String do |s1, s2|
      [s1, s2]
    end
    
    overload :x, Array do |a|
      "array"
    end

  end

  def setup
    @x = X.new
  end

  def test_x
    assert_equal( "hello", @x.x )
  end

  def test_i
    assert_equal( 1, @x.x(1) )
  end

  def test_strings
    assert_equal( ["a","b"], @x.x("a","b") )
  end

  def test_symbol_string
    assert_equal( [:a,"b"], @x.x(:a,"b") )
  end

  def test_sym
    assert_equal( :sym, @x.x(:sym) )
  end
  
  def test_subarray
    assert_equal("array", @x.x([]))
    assert_equal("array", @x.x(SubArray.new))
    assert_equal("array", @x.x(SubSubArray.new))
  end
  
  def test_raise
    assert_raise ArgumentError do
       X.module_eval do
        overload :x, 42 do end 
      end
    end
  end
end



