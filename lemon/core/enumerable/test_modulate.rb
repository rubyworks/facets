require 'facets/enumerable/modulate'

Case Enumerable do

  Unit :modulate do
    a = [2,4,6,8]
    r = a.modulate(2)
    x = [[2,6],[4,8]]
    r.assert == x
  end

end

