Covers 'facets/array/recursive'

TestCase Array do

  Unit :recursive => "each" do
    r = []
    [1,2,['a','b']].recursive.each{ |v| r << v }
    r.assert == [1,2,'a','b']
  end

  Unit :recursive => "map" do
    r = [1,2,['a','b']].recursive.map{ |v| v.succ }
    r.assert == [2,3,['b','c']]
  end

end

