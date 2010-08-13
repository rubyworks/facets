covers 'facets/array/pull'

tests Array do

  unit :pull do
    a = [1,2,3]
    a.pull.assert == 1
    a.assert == [1,2]
  end

  unit :pull do
    a = [1,2,3]
    a.pull.assert == 1
    a.assert == [2,3]
  end

end
