covers 'facets/enumerable/recursively'

testcase Enumerable do

  c = Class.new do
    include Enumerable
    def initialize(ary)
      @ary = ary
    end
    def each(&b)
      @ary.each(&b)
    end
  end

  unit :recursively => "each" do
    e = c.new [1,2,['a','b']]
    a = []
    e.recursively(Enumerable).each{ |v| a << v }
    a.assert == [1,2,'a','b']
  end

  unit :recursively => "map" do
    e = c.new [1,2,['a','b']]
    a = e.recursively(Enumerable).map{ |v| v.succ }
    a.assert == [2,3,['b','c']]
  end

end

