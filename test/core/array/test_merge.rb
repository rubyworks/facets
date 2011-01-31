covers 'facets/array/merge'

testcase Array do

  unit :merge do
    a = [1,2,3]
    b = [3,4,5]
    a.merge(b).assert == [1,2,3,4,5]
  end

  unit :merge! do
    a = [1,2,3]
    b = [3,4,5]
    a.merge!(b)
    a.assert == [1,2,3,4,5]
  end

end

