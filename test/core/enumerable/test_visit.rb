covers 'facets/enumerable/visit'

testcase Enumerable do

  unit :visit do
    r = [1, 2, 8..9].visit{ |x| x.succ }
    r.assert == [2, 3, [9, 10]]
  end  

end
