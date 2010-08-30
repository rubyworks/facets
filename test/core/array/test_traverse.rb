covers 'facets/array/traverse'

testcase Array do

  unit :traverse do
    a = ["A", "B", ["X", "Y"]]
    g = a.traverse{ |e| e.downcase }
    g.assert == ["a", "b", ["x", "y"]]
  end

  unit :traverse! do
    a = ["A", "B", ["X", "Y"]]
    a.traverse!{ |e| e.downcase }
    a.assert == ["a", "b", ["x", "y"]]
  end

end

