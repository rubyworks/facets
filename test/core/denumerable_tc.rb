covers 'facets/denumerable'
covers 'facets/enumerable/defer'
#require 'facets/enumerable/take'

test_case Denumerable do

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

  method :map do
    test do
      o = c.new(1,2,3,4)
      o.map.assert.is_a?(Denumerator)
      o.map{ |x| x + 1 }.assert.is_a?(Denumerator)
      o.map{ |x| x + 1 }.to_a.assert == [2,3,4,5]
    end
  end

  method :collect do
    test do
      o = c.new(1,2,3,4)
      o.collect.assert.is_a?(Denumerator)
      o.collect{ |x| x + 1 }.assert.is_a?(Denumerator)
      o.collect{ |x| x + 1 }.to_a.assert == [2,3,4,5]
    end
  end

  method :select do
    test do
      o = c.new(1,2,3,4)
      o.select.assert.is_a?(Denumerator)
      o.select{ |x| x > 1 }.assert.is_a?(Denumerator)
      o.select{ |x| x > 1 }.to_a.assert == [2,3,4]
    end
  end

  method :find_all do
    test do
      o = c.new(1,2,3,4)
      o.find_all.assert.is_a?(Denumerator)
      o.find_all{ |x| x > 1 }.assert.is_a?(Denumerator)
      o.find_all{ |x| x > 1 }.to_a.assert == [2,3,4]
    end
  end

  method :reject do
    test do
      o = c.new(1,2,3,4)
      o.reject.assert.is_a?(Denumerator)
      o.reject{ |x| x > 1 }.assert.is_a?(Denumerator)
      o.reject{ |x| x > 1 }.to_a.assert == [1]
    end
  end

  method :skip do
    test do
      o = c.new(1,2,3,4)
      o.skip(2).assert.is_a?(Denumerator)
      o.skip(2).to_a.assert == [3,4]
    end
  end

  method :take do
    test do
      o = c.new(1,2,3,4)
      o.take(2).assert.is_a?(Denumerator)
      o.take(2).to_a.assert == [1,2]
    end
  end

end

test_case Denumerator do

  source = (1..1/0.0)   # infinite Enumerable object

  method :each do
    test do
      res = []
      (1..5).defer.each { |i| res << i }
      res.assert == [1,2,3,4,5]
    end
  end

  method :take do
    test do
      d = source.defer
      d.take(5).to_a.assert == [1,2,3,4,5]
    end
  end

  method :inject do
    test do
      d = (1..5).defer
      d = d.inject({}) { |h,v| h[v] = v*2; h }
      d.assert == {1=>2,2=>4,3=>6,4=>8,5=>10}
    end

    # TODO: problem with break in proc
    #test do
    #  d = (1..5).defer
    #  d = d.inject({}){ |h,v| h[v] = v*2; break h if v>=3; h }
    #  d.assert == {1=>2,2=>4,3=>6}
    #end
  end

  method :max do
    test do
      d = source.defer
      d.take(5).max.assert == 5
    end
  end

  method :min do
    test do
      d = source.defer
      d.take(5).min.assert == 1
    end
  end

  method :sort_by do
    test do
      d = source.defer
      d.take(5).sort_by{ |x| -x }.assert == [5,4,3,2,1]
    end
  end

  method :map do
    test do
      d = source.defer
      d.map{ |i| i*2 }.take(5).min.assert == 2
    end
  end

  method :defer do
    test do
      d = source.defer.defer{ |out,i| out << i*2 }
      d.take(5).to_a.assert == [2,4,6,8,10]
    end

    test "chain" do
      d = source.defer { |out,i| out.yield(i) if i % 2 == 0 }.
                 defer { |out,i| out.yield(i + 100) }
      d.take(5).to_a.assert == [102,104,106,108,110]
    end
  end

  method :select do
    test do
      d = source.defer
      d = d.select{ |i| i % 2 == 0 }
      d.take(5).to_a.assert == [2,4,6,8,10]
    end
  end

  method :find_all do
    test do
      d = source.defer
      d = d.find_all{ |i| i % 2 == 0 }
      d.take(5).to_a.assert == [2,4,6,8,10]
    end
  end

  method :reject do
    test do
      d = source.defer
      d = d.reject { |i| i % 3 == 0 }
      d.take(5).to_a.assert == [1,2,4,5,7]
    end
  end

  method :skip do
    test do
      d = source.defer
      d = d.skip(20)
      d.take(5).to_a.assert == [21,22,23,24,25]
    end
  end

  #method :each_cons
  #  test do
  #    a = source.defer
  #    assert_equal [[1,2,3],[2,3,4],[3,4,5],[4,5,6]], a.each_cons(3).take(4)
  #  end
  #end
end
