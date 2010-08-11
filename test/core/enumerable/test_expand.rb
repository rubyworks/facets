covers 'facets/enumerable/expand'

tests Enumerable do

  unit :expand do
    a = [1,2,2,[1,2]]
    r = a.expand
    r.result == [1,2,2,1,2]
  end

end
