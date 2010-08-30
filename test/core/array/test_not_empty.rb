covers 'facets/array/not_empty'

testcase Array do

  unit :not_empty? do
    [].refute.not_empty?
  end

  unit :not_empty? do
    [1,2].assert.not_empty?
  end

end
