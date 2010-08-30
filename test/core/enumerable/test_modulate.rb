covers 'facets/enumerable/modulate'

testcase Enumerable do

  unit :modulate do
    a = [2,4,6,8]
    r = a.modulate(2)
    x = [[2,6],[4,8]]
    r.assert == x
  end

end

