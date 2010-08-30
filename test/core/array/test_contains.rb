covers 'facets/array/contains'

testcase Array do

  unit :contains? do
    [1,2,3,4].assert.contains?(2)
    [1,2,3,4].refute.contains?(9)
  end

end
