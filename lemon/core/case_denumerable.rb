require 'facets/enumerable/defer'
require 'facets/enumerable/take'

Case Enumerable do

  Unit :defer do
    Denumerator.assert === [1,2,3,4].defer
  end

  SOURCE = (1..1/0.0)   # infinite Enumerable object

  Unit :enumerator_with_block
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
  
  Unit :defer_without_block
    a = SOURCE.defer
    assert_equal Denumerator, a.class
    assert_equal [1,2,3,4,5], a.take(5).to_a
  end

  Unit :defer_with_block
    a = SOURCE.defer { |out,i| out << i*2 }
    assert_equal Denumerator, a.class
    assert_equal [2,4,6,8,10], a.take(5).to_a
  end

  Unit :each
    res = []
    (1..5).defer.each { |i| res << i }
    assert_equal [1,2,3,4,5], res
  end

  Unit :return
    res = (1..5).defer.inject({}) { |h,v| h[v] = v*2; h }
    assert_equal({1=>2,2=>4,3=>6,4=>8,5=>10}, res)
    res = (1..5).defer.inject({}) { |h,v| h[v] = v*2; break h if v>=3; h }
    assert_equal({1=>2,2=>4,3=>6}, res)
  end

  Unit :other_enumerable
    a = SOURCE.defer
    assert_equal 5, a.take(5).max
    assert_equal 2, a.map { |i| i*2 }.take(5).min
    assert_equal [5,4,3,2,1], a.take(5).sort_by { |x| -x }
  end

  Unit :defer_defer
    a = SOURCE.defer.defer { |out,i| out << i*2 }
    assert_equal [2,4,6,8,10], a.take(5).to_a
  end

  Unit :defer_chain
    a = SOURCE.defer { |out,i| out.yield(i) if i % 2 == 0 }.
               defer { |out,i| out.yield(i + 100) }
    assert_equal [102,104,106,108,110], a.take(5).to_a
  end

  Unit :select_map
    a = SOURCE.defer.select { |i| i % 2 == 0 }.map { |i| i + 100 }
    assert_equal [102,104,106,108,110], a.take(5).to_a
  end

  Unit :find_all_collect
    a = SOURCE.defer.find_all { |i| i % 2 == 0 }.collect { |i| i + 100 }
    assert_equal [102,104,106,108,110], a.take(5).to_a
  end

  Unit :reject
    a = SOURCE.defer.reject { |i| i % 3 == 0 }
    assert_equal [1,2,4,5,7], a.take(5).to_a
  end

  Unit :skip_take
    a = SOURCE.defer.skip(20).take(5)
    assert_equal [21,22,23,24,25], a.to_a
  end

  #Unit :each_cons
  #  a = SOURCE.defer
  #  assert_equal [[1,2,3],[2,3,4],[3,4,5],[4,5,6]], a.each_cons(3).take(4)
  #end
end

