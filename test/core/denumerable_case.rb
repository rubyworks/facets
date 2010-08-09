require 'facets/enumerable/defer'
require 'facets/enumerable/take'

Case Denumerator do

  source = (1..1/0.0)   # infinite Enumerable object

  Unit :each do
    res = []
    (1..5).defer.each { |i| res << i }
    res.assert == [1,2,3,4,5]
  end

  Unit :take do
    d = source.defer
    d.take(5).to_a.assert == [1,2,3,4,5]
  end

  Unit :inject do
    d = (1..5).defer
    d = d.inject({}) { |h,v| h[v] = v*2; h }
    d.assert == {1=>2,2=>4,3=>6,4=>8,5=>10}
  end

  Omit :inject => "can't use break in proc?" do
    d = (1..5).defer
    d = d.inject({}){ |h,v| h[v] = v*2; break h if v>=3; h }
    d.assert == {1=>2,2=>4,3=>6}
  end

  Unit :max do
    d = source.defer
    d.take(5).max.assert == 5
  end

  Unit :min do
    d = source.defer
    d.take(5).min.assert == 1
  end

  Unit :sort_by do
    d = source.defer
    d.take(5).sort_by{ |x| -x }.assert == [5,4,3,2,1]
  end

  Unit :map do
    d = source.defer
    d.map{ |i| i*2 }.take(5).min.assert == 2
  end

  Unit :defer do
    d = source.defer.defer{ |out,i| out << i*2 }
    d.take(5).to_a.assert == [2,4,6,8,10]
  end

  Unit :defer => "chain" do
    d = source.defer { |out,i| out.yield(i) if i % 2 == 0 }.
               defer { |out,i| out.yield(i + 100) }
    d.take(5).to_a.assert == [102,104,106,108,110]
  end

  Unit :select do
    d = source.defer
    d = d.select{ |i| i % 2 == 0 }
    d.take(5).to_a.assert == [2,4,6,8,10]
  end

  Unit :find_all do
    d = source.defer
    d = d.find_all{ |i| i % 2 == 0 }
    d.take(5).to_a.assert == [2,4,6,8,10]
  end

  Unit :reject do
    d = source.defer
    d = d.reject { |i| i % 3 == 0 }
    d.take(5).to_a.assert == [1,2,4,5,7]
  end

  Unit :skip do
    d = source.defer
    d = d.skip(20)
    d.take(5).to_a.assert == [21,22,23,24,25]
  end

  #Unit :each_cons
  #  a = source.defer
  #  assert_equal [[1,2,3],[2,3,4],[3,4,5],[4,5,6]], a.each_cons(3).take(4)
  #end
end

