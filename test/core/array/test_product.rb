Covers 'facets/array/product'

TestCase Array do

  Unit :product => "single argument" do
    r = [1,2,3].product([4,5,6])
    x = [[1, 4],[1, 5],[1, 6],[2, 4],[2, 5],[2, 6],[3, 4],[3, 5],[3, 6]]
    r.assert == x
  end

  Unit :product => "multiple arguments" do
    a = %w|a b|
    b = %w|a x|
    c = %w|x y|
    r = a.product(b, c)
    x = [ ["a", "a", "x"],
          ["a", "a", "y"],
          ["a", "x", "x"],
          ["a", "x", "y"],
          ["b", "a", "x"],
          ["b", "a", "y"],
          ["b", "x", "x"],
          ["b", "x", "y"] ]
    r.assert == x
  end

  #def test_product_01
  #  i = [[1,2], [4], ["apple", "banana"]]
  #  o = [[1, 4, "apple"], [1, 4, "banana"], [2, 4, "apple"], [2, 4, "banana"]]
  #  assert_equal( o, Enumerable.product(*i) )
  #end

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


  #def test_op_mod
  #  a = [:A,:B,:C]
  #  assert_equal( a[1], a/1 )
  #  assert_equal( :B, a/1 )
  #end
  #
  #def test_op_div
  #  a = [:A,:B,:C]
  #  assert_equal( a[1], a/1 )
  #  assert_equal( :B, a/1 )
  #end

end


