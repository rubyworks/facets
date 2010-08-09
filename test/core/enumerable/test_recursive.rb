Covers 'facets/enumerable/recursive'

Case Enumerable do

  c = Class.new do
    include Enumerable
    def initialize(ary)
      @ary = ary
    end
    def each(&b)
      @ary.each(&b)
    end
  end

  Unit :recursive => "each" do
    e = c.new [1,2,['a','b']]
    a = []
    e.recursive(Enumerable).each{ |v| a << v }
    a.assert == [1,2,'a','b']
  end

  Unit :recursive => "map" do
    e = c.new [1,2,['a','b']]
    a = e.recursive(Enumerable).map{ |v| v.succ }
    a.assert == [2,3,['b','c']]
  end

end

