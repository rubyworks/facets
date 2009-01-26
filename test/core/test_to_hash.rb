require 'facets/to_hash.rb'
require 'test/unit'


class TestArrayConversion < Test::Unit::TestCase

  def test_to_h
    a = [[1,2],[3,4],[5,6]]
    assert_equal( { 1=>2, 3=>4, 5=>6 }, a.to_h )
  end

  def test_to_h_arrayed
    a = [[:a,1,2],[:b,3,4],[:c,5,6]]
    assert_equal( { :a=>[1,2], :b=>[3,4], :c=>[5,6] }, a.to_h(true) )
  end

  #def test_to_hash
  #  a = [:a,:b,:c]
  #  assert_equal( { 0=>:a, 1=>:b, 2=>:c }, a.to_hash )
  #end

end



class TestEnumerableConversion < Test::Unit::TestCase

  def test_to_h
    a = [[1,:a],[2,:b],[3,:c]]
    assert_equal( { 1=>:a, 2=>:b, 3=>:c }, a.to_h )
  end

  #def test_to_hash
  #  a = [:a,:b,:c]
  #  assert_equal( { 0=>:a, 1=>:b, 2=>:c }, a.to_hash )
  #end

end


class TestHashConversion < Test::Unit::TestCase

  def test_to_h
    a = { :a => 1, :b => 2, :c => 3 }
    assert_equal( a, a.to_h )
  end

end


class TestNilClassConversion < Test::Unit::TestCase

  def test_to_h
    assert_equal( {}, nil.to_h )
  end

end

