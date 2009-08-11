require 'facets/thread.rb'
require 'test/unit'

class TC_Thread < Test::Unit::TestCase

  def test_threaded_map
    r = [1,2,3].threaded_map{ |e| e + 1 }
    assert_equal([2,3,4], r)
  end

  def test_threaded_map_send
    r = [1,2,3].threaded_map_send(:+, 1)
    assert_equal([2,3,4], r)
  end

  def test_map_send_with_block
    r = [[1,2,3],[2,3,4],[3,4,5]].threaded_map_send(:select){ |x| x > 2 }
    assert_equal([[3],[3,4],[3,4,5]], r)
  end

end

