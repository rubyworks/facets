require 'facets/enumerable/defer'
require 'facets/enumerable/take'

Case Enumerable do

  Unit :defer do
    Denumerator.assert === [1,2,3,4].defer
  end

  SOURCE = (1..1/0.0)   # infinite Enumerable object

  Unit :enumerator_with_block do
    # This example taken from ri19 Enumerator.new
    fib = Enumerator.new { |y|
      a = b = 1
      loop {
        y << a
        a, b = b, a + b
      }
    }
    fib.take(10).assert == [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
  end

  Unit :defer_without_block do
    a = SOURCE.defer
    a.class.assert == Denumerator
    a.take(5).to_a.assert == [1,2,3,4,5]
  end

  Unit :defer_with_block do
    a = SOURCE.defer { |out,i| out << i*2 }
    a.class.assert == Denumerator
    a.take(5).to_a.assert == [2,4,6,8,10]
  end

  Unit :defer => "each" do
    res = []
    (1..5).defer.each { |i| res << i }
    res.assert == [1,2,3,4,5]
  end

  Unit :defer => "inject" do
    res = (1..5).defer.inject({}) { |h,v| h[v] = v*2; h }
    res.assert == {1=>2,2=>4,3=>6,4=>8,5=>10}

    res = (1..5).defer.inject({}) { |h,v| h[v] = v*2; break h if v>=3; h }
    res.assert == {1=>2,2=>4,3=>6}
  end

  Unit :other_enumerable do
    a = SOURCE.defer
    assert_equal 5, a.take(5).max
    assert_equal 2, a.map { |i| i*2 }.take(5).min
    a.take(5).sort_by { |x| -x }.assert == [5,4,3,2,1]
  end

  Unit :defer_defer do
    a = SOURCE.defer.defer { |out,i| out << i*2 }
     a.take(5).to_a.assert == [2,4,6,8,10]
  end

  Unit :defer_chain do
    a = SOURCE.defer { |out,i| out.yield(i) if i % 2 == 0 }.
               defer { |out,i| out.yield(i + 100) }
     a.take(5).to_a.assert == [102,104,106,108,110]
  end

  Unit :defer => "select and map" do
    a = SOURCE.defer.select{ |i| i % 2 == 0 }.map{ |i| i + 100 }
    a.take(5).to_a.assert == [102,104,106,108,110]
  end

  Unit :find_all_collect do
    a = SOURCE.defer.find_all { |i| i % 2 == 0 }.collect { |i| i + 100 }
    a.take(5).to_a.assert == [102,104,106,108,110]
  end

  Unit :reject do
    a = SOURCE.defer.reject { |i| i % 3 == 0 }
    a.take(5).to_a.assert == [1,2,4,5,7]
  end

  Unit :skip_take do
    a = SOURCE.defer.skip(20).take(5)
    a.to_a.assert == [21,22,23,24,25]
  end

  #Unit :each_cons
  #  a = SOURCE.defer
  #  assert_equal [[1,2,3],[2,3,4],[3,4,5],[4,5,6]], a.each_cons(3).take(4)
  #end
end

