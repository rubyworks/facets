covers 'facets/array/pull'

tests Array do

  unit :peek do
    a = [1,2,3]
    a.peek.assert == 3
    a.assert == [1,2,3]
  end

  unit :peek do
    a = [1,2,3]
    a.peek(1).assert == 2
    a.assert == [1,2,3]
  end

  unit :peek do
    a = [1,2,3]
    a.peek(-1).assert == 1
    a.assert == [1,2,3]
  end

end

