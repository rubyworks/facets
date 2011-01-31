covers 'facets/kernel/in'

tests Kernel do

  unit :in? do
    5.assert.in?(0..10)
    5.assert.in?([1,2,3,4,5])
  end

end
