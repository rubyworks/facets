require 'facets/enumerable/commonality.rb'

Case Enumerable do

  Unit :commonality do
    a = [1,2,2,3,3,3]
    e = { 2 => [2,2], 3 => [3,3,3] }
    r = a.commonality
    r.assert == e
  end

  Unit :commonality => "with block" do
    a = [1,2,2,3,3,3]
    e = {false=>[1, 2, 2], true=>[3, 3, 3]}
    r = a.commonality{ |x| x > 2 }
    r.assert == e
  end

end
