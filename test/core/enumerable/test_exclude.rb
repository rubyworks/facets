covers 'facets/enumerable/exclude'

tests Enumerable do

  unit :exclude? do
    a = [1,2,2,3]
    a.refute.exclude?(2)
    a.assert.exclude?(4)
  end

end
