covers 'facets/integer/of'

testcase Integer do

  unit :of do
    a = 4
    b = a.of{ |i| i*2 }
    b.assert == [0,2,4,6]
  end

  unit :times_collect do
    a = 4
    b = a.times_collect{ |i| i*2 }
    b.assert == [0,2,4,6]
  end

  unit :times_map do
    a = 4
    b = a.times_map{ |i| i*2 }
    b.assert == [0,2,4,6]
  end

end

