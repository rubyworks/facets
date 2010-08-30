covers 'facets/array/splice'

testcase Array do

  unit :splice do
    a = [1,2,3]
    a.splice(1).assert == 2
    a.assert == [1,3]
  end

  unit :splice do
    a = [1,2,3]
    a.splice(1,4).assert == 4
    a.assert == [1,4,3]
  end

end
