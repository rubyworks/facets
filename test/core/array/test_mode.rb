covers 'facets/array/mode'

tests Array do

  unit :mode do
    [1, 1, 2, 3].mode.assert == [1]
  end

  unit :mode do
    [1, 1, 2, 2, 3].mode.sort.assert == [1,2]
  end

end
