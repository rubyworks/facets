covers 'facets/array/nonuniq'

testcase Array do

  unit :nonuniq do
    a = [1,1,2,2,3,4,5]
    a.nonuniq.assert == [1,2]
  end

  unit :nonuniq! do
    a = [1,1,2,2,3,4,5]
    a.nonuniq!
    a.assert == [1,2]
  end

end

