covers 'facets/array/select'

testcase Array do

  unit :select! do
    a = [1,2,3,4,5,6,7,8,9,10]
    a.select!{ |e| e % 2 == 0 }
    a.assert == [2,4,6,8,10]
  end

end

