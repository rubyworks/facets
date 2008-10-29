require 'facets/array/product'
require 'test/unit'

class TC_Array_Product < Test::Unit::TestCase

  def test_product
    a = %w|a b|
    b = %w|a x|
    c = %w|x y|
    z = a.product(b, c)
    r = [ ["a", "a", "x"],
          ["a", "a", "y"],
          ["a", "x", "x"],
          ["a", "x", "y"],
          ["b", "a", "x"],
          ["b", "a", "y"],
          ["b", "x", "x"],
          ["b", "x", "y"] ]
    assert_equal( r, z )
  end

  def test_op_product
    a = [1,2,3] ** [4,5,6]
    assert_equal( [[1, 4],[1, 5],[1, 6],[2, 4],[2, 5],[2, 6],[3, 4],[3, 5],[3, 6]], a )
  end

  #def test_product_01
  #  i = [[1,2], [4], ["apple", "banana"]]
  #  o = [[1, 4, "apple"], [1, 4, "banana"], [2, 4, "apple"], [2, 4, "banana"]]
  #  assert_equal( o, Enumerable.product(*i) )
  #end

  def test_product_02
    a = [1,2,3].product([4,5,6])
    assert_equal( [[1, 4],[1, 5],[1, 6],[2, 4],[2, 5],[2, 6],[3, 4],[3, 5],[3, 6]], a )
  end

  def test_product_03
    a = []
    [1,2,3].product([4,5,6]) {|elem| a << elem }
    assert_equal( [[1, 4],[1, 5],[1, 6],[2, 4],[2, 5],[2, 6],[3, 4],[3, 5],[3, 6]], a )
  end

  #     def test_op_mod
  #       a = [:A,:B,:C]
  #       assert_equal( a[1], a/1 )
  #       assert_equal( :B, a/1 )
  #     end
  #
  #     def test_op_div
  #       a = [:A,:B,:C]
  #       assert_equal( a[1], a/1 )
  #       assert_equal( :B, a/1 )
  #     end

end


