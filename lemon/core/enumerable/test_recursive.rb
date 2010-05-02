require 'facets/enumerable/recursive'

Case Enumerable do

  Unit :recursive => "each" do
    a = []
    [1,2,['a','b']].recursive.each{ |v| a << v }
    a.assert == [1,2,'a','b']
  end

  Unit :recursive => "map" do
    a = [1,2,['a','b']].recursive.map{ |v| v.succ }
    a.assert == [2,3,['b','c']]
  end

end

