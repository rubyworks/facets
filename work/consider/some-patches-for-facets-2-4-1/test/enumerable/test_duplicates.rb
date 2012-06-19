$:.unshift File.join( %w{ .. .. lib } )
require 'facets/enumerable/duplicates1'
require 'test/unit'

class TC_Enumerable_Duplicated < Test::Unit::TestCase

  def test_nonuniq
    a = [1,1,2,2,3,4,5]
    assert_equal( [1,2] , a.nonuniq.sort )
  end

  def test_at_least_times
    a = [0,1,2,3,4,5,
         0,1,2,3,4,
         0,1,2,3,
         0,1,2,
         0,1,
         0]
    (1..6).each do |n|
      assert_equal( [*0..6-n], a.at_least_times( n ).sort, "wrong testcase #{n}" )
    end

  end

end

