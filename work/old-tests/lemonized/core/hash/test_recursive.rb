require 'facets/hash/recursive'
require 'test/unit'

class TestHashRecursive < Test::Unit::TestCase

  def test_each
    a = []
    {:a=>1,:b=>{:c=>3}}.recursive.each{ |k,v| a << [k,v] }
    assert_equal([[:a,1],[:c,3], [:b,{:c=>3}]], a)
  end

  def test_map_moot
    a = {:a=>1,:b=>{:c=>3}}.recursive.map{ |k,v| [k, v] }
    assert_equal([[:a,1],[:b,[[:c,3]]]], a)
  end

  def test_map
    a = {:a=>1,:b=>{:c=>3}}.recursive.map{ |k,v| Hash===v ? [k, v.succ] : [k,v] }
    assert_equal([[:a,1],[:b,[[:c,3]]]], a)
  end

end

