covers 'facets/enumerable/ewise'

testcase Enumerable do

  unit :ewise do
    a = [1,2,3]
    (a.ewise + 3).assert == [4,5,6]
    (a.ewise + [4,5]).assert == [5,7]
    (a.ewise.+([4,5],2)).assert == [[5,7],[3,4,5]]
    (a.ewise.+([4,5],3)).assert == [[5,7],[4,5,6]]
  end

  unit :elementwise do
    a = [1,2,3]
    (a.elementwise + 3).assert == [4,5,6]
    (a.elementwise + [4,5]).assert == [5,7]
    (a.elementwise.+([4,5],2)).assert == [[5,7],[3,4,5]]
    (a.elementwise.+([4,5],3)).assert == [[5,7],[4,5,6]]
  end

end

