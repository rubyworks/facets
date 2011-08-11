covers 'facets/array/pull'

test_case Array do

  method :poke do

    test do
      a = [1,2,3]
      a.poke(9)
      a.assert == [9,1,2,3]
    end

    test do
      a = [2,3]
      a.poke(1).assert == [1,2,3]
      a.poke(4).assert == [4,1,2,3]
    end

  end

end
