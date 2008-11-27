require 'facets/filter'
require 'test/unit'

class TC_Enumerator_Filter < Test::Unit::TestCase

  SOURCE = (1..1/0.0)   # infinite Enumerable object

  def test_enumerator_with_block
    # This example taken from ri19 Enumerator.new
    fib = Enumerator.new { |y|
      a = b = 1
      loop {
        y << a
        a, b = b, a + b
      }
    }
    assert_equal [1, 1, 2, 3, 5, 8, 13, 21, 34, 55], fib.take(10)
  end
  
  def test_filter_without_block
    a = SOURCE.filter
    assert_equal Enumerator::Filter, a.class
    assert_equal [1,2,3,4,5], a.take(5).to_a
  end

  def test_filter_with_block
    a = SOURCE.filter { |out,i| out << i*2 }
    assert_equal Enumerator::Filter, a.class
    assert_equal [2,4,6,8,10], a.take(5).to_a
  end

  def test_each
    res = []
    (1..5).filter.each { |i| res << i }
    assert_equal [1,2,3,4,5], res
  end

  def test_return
    res = (1..5).filter.inject({}) { |h,v| h[v] = v*2; h }
    assert_equal({1=>2,2=>4,3=>6,4=>8,5=>10}, res)
    res = (1..5).filter.inject({}) { |h,v| h[v] = v*2; break h if v>=3; h }
    assert_equal({1=>2,2=>4,3=>6}, res)
  end

  def test_other_enumerable
    a = SOURCE.filter
    assert_equal 5, a.take(5).max
    assert_equal 2, a.map { |i| i*2 }.take(5).min
    assert_equal [5,4,3,2,1], a.take(5).sort_by { |x| -x }
  end

  def test_filter_filter
    a = SOURCE.filter.filter { |out,i| out << i*2 }
    assert_equal [2,4,6,8,10], a.take(5).to_a
  end

  def test_filter_chain
    a = SOURCE.filter { |out,i| out.yield(i) if i % 2 == 0 }.
               filter { |out,i| out.yield(i + 100) }
    assert_equal [102,104,106,108,110], a.take(5).to_a
  end

  def test_select_map
    a = SOURCE.filter.select { |i| i % 2 == 0 }.map { |i| i + 100 }
    assert_equal [102,104,106,108,110], a.take(5).to_a
  end

  def test_find_all_collect
    a = SOURCE.filter.find_all { |i| i % 2 == 0 }.collect { |i| i + 100 }
    assert_equal [102,104,106,108,110], a.take(5).to_a
  end

  def test_reject
    a = SOURCE.filter.reject { |i| i % 3 == 0 }
    assert_equal [1,2,4,5,7], a.take(5).to_a
  end

  def test_skip_take
    a = SOURCE.filter.skip(20).take(5)
    assert_equal [21,22,23,24,25], a.to_a
  end

  #def test_each_cons
  #  a = SOURCE.filter
  #  assert_equal [[1,2,3],[2,3,4],[3,4,5],[4,5,6]], a.each_cons(3).take(4)
  #end
end
