require 'facets/enumerable/cluster_by'
require 'test/unit'

class TC_Enumerable_Prime < Test::Unit::TestCase

  def test_cluster_by
    a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    r = [[0, 2, 4, 6, 8], [1, 3, 5, 7, 9]]
    assert_equal(r, a.cluster_by{|e| e%2}.each{|a| a.sort!})
    h = {0=>0, 1=>1, 2=>2, 3=>3, 4=>4, 5=>5, 6=>6, 7=>7, 8=>8, 9=>9}
    r = [[[0, 0], [2, 2], [4, 4], [6, 6], [8, 8]], [[1, 1], [3, 3], [5, 5], [7, 7], [9, 9]]]
    assert_equal(r, h.cluster_by{|k, v| v%2}.each{|a| a.sort!})
  end

  def test_cluster_by_empty
    r = [].cluster_by{ |a| a }
    assert_equal([], r)
  end

end


