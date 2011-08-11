covers 'facets/array/traverse'

test_case Array do

  method :traverse do

    test do
      a = ["A", "B", ["X", "Y"]]
      g = a.traverse{ |e| e.downcase }
      g.assert == ["a", "b", ["x", "y"]]
    end

  end

  method :traverse! do

    test do
      a = ["A", "B", ["X", "Y"]]
      a.traverse!{ |e| e.downcase }
      a.assert == ["a", "b", ["x", "y"]]
    end

  end

end

