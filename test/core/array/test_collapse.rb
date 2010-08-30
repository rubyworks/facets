covers 'facets/array/collapse'

testcase Array do

  unit :collapse do
    [1,nil,[1,2],nil,[[3]]].collapse.assert == [1,1,2,3]
  end

end

