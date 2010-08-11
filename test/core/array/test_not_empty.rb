Covers 'facets/array/not_empty'

TestCase Array do

  unit :not_empty? do
    [].refute.not_empty?
  end

  unit :not_empty? do
    [1,2].assert.not_empty?
  end

end
