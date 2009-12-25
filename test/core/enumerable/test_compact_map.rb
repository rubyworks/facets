require 'facets/enumerable/compact_map.rb'
require 'test/unit'

class TestEnumerable < Test::Unit::TestCase

  #def test_filter_collect
  #  e = [3,4]
  #  a = [1,2,3,4].filter_collect { |n|
  #    throw(:skip) if n < 3
  #    n
  #  }
  #  assert_equal( e, a )
  #end

  def test_compact_map
    a = [1,2,nil,4].compact_map { |e| e }
    assert_equal( [1,2,4], a )
  end

=begin
  def test_map_send
    r = [1,2,3].map_send(:+, 1)
    assert_equal(r, [2,3,4])
  end

  def test_map_send_with_block
    r = [1,2,3].map_send(:+,1){ |x| x + 1 }
    assert_equal(r, [3,4,5])
  end
=end

end
