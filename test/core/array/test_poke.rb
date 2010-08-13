covers 'facets/array/pull'

tests Array do

  unit :poke do
    a = [1,2,3]
    a.poke(9)
    a.assert == [9,1,2,3]
  end

  unit :poke do
    a = [2,3]
    a.poke(1).assert == [1,2,3]
    a.poke(4).assert == [4,1,2,3]
  end

end
