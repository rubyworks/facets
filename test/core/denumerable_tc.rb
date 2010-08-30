covers 'facets/denumerable'
#require 'facets/enumerable/defer'
#require 'facets/enumerable/take'

tests Denumerable do

  c = Class.new do
    include Denumerable
    def initialize(*a)
      @a = a
    end
    def each(&blk)
      @a.each(&blk)
    end
    def size; @a.size; end
  end

  unit :map do
    o = c.new(1,2,3,4)
    o.map.assert.is_a?(Denumerator)
    o.map{ |x| x + 1 }.assert.is_a?(Denumerator)
    o.map{ |x| x + 1 }.to_a.assert == [2,3,4,5]
  end

  unit :collect do
    o = c.new(1,2,3,4)
    o.collect.assert.is_a?(Denumerator)
    o.collect{ |x| x + 1 }.assert.is_a?(Denumerator)
    o.collect{ |x| x + 1 }.to_a.assert == [2,3,4,5]
  end

  unit :select do
    o = c.new(1,2,3,4)
    o.select.assert.is_a?(Denumerator)
    o.select{ |x| x > 1 }.assert.is_a?(Denumerator)
    o.select{ |x| x > 1 }.to_a.assert == [2,3,4]
  end

  unit :find_all do
    o = c.new(1,2,3,4)
    o.find_all.assert.is_a?(Denumerator)
    o.find_all{ |x| x > 1 }.assert.is_a?(Denumerator)
    o.find_all{ |x| x > 1 }.to_a.assert == [2,3,4]
  end

  unit :reject do
    o = c.new(1,2,3,4)
    o.reject.assert.is_a?(Denumerator)
    o.reject{ |x| x > 1 }.assert.is_a?(Denumerator)
    o.reject{ |x| x > 1 }.to_a.assert == [1]
  end

  unit :skip do
    o = c.new(1,2,3,4)
    o.skip(2).assert.is_a?(Denumerator)
    o.skip(2).to_a.assert == [3,4]
  end

  unit :take do
    o = c.new(1,2,3,4)
    o.take(2).assert.is_a?(Denumerator)
    o.take(2).to_a.assert == [1,2]
  end

end

tests Denumerator do

  source = (1..1/0.0)   # infinite Enumerable object

  unit :each do
    res = []
    (1..5).defer.each { |i| res << i }
    res.assert == [1,2,3,4,5]
  end

  unit :take do
    d = source.defer
    d.take(5).to_a.assert == [1,2,3,4,5]
  end

  unit :inject do
    d = (1..5).defer
    d = d.inject({}) { |h,v| h[v] = v*2; h }
    d.assert == {1=>2,2=>4,3=>6,4=>8,5=>10}
  end

  omit unit :inject => "can't use break in proc?" do
    d = (1..5).defer
    d = d.inject({}){ |h,v| h[v] = v*2; break h if v>=3; h }
    d.assert == {1=>2,2=>4,3=>6}
  end

  unit :max do
    d = source.defer
    d.take(5).max.assert == 5
  end

  unit :min do
    d = source.defer
    d.take(5).min.assert == 1
  end

  unit :sort_by do
    d = source.defer
    d.take(5).sort_by{ |x| -x }.assert == [5,4,3,2,1]
  end

  unit :map do
    d = source.defer
    d.map{ |i| i*2 }.take(5).min.assert == 2
  end

  unit :defer do
    d = source.defer.defer{ |out,i| out << i*2 }
    d.take(5).to_a.assert == [2,4,6,8,10]
  end

  unit :defer => "chain" do
    d = source.defer { |out,i| out.yield(i) if i % 2 == 0 }.
               defer { |out,i| out.yield(i + 100) }
    d.take(5).to_a.assert == [102,104,106,108,110]
  end

  unit :select do
    d = source.defer
    d = d.select{ |i| i % 2 == 0 }
    d.take(5).to_a.assert == [2,4,6,8,10]
  end

  unit :find_all do
    d = source.defer
    d = d.find_all{ |i| i % 2 == 0 }
    d.take(5).to_a.assert == [2,4,6,8,10]
  end

  unit :reject do
    d = source.defer
    d = d.reject { |i| i % 3 == 0 }
    d.take(5).to_a.assert == [1,2,4,5,7]
  end

  unit :skip do
    d = source.defer
    d = d.skip(20)
    d.take(5).to_a.assert == [21,22,23,24,25]
  end

  #unit :each_cons
  #  a = source.defer
  #  assert_equal [[1,2,3],[2,3,4],[3,4,5],[4,5,6]], a.each_cons(3).take(4)
  #end
end

