covers 'facets/array/duplicates'

testcase Array do

  unit :duplicates do
    a = [1,1,2,2,3,4,5]
    a.duplicates.assert == [1,2]
  end

end

