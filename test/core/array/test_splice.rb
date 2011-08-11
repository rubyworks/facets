covers 'facets/array/splice'

test_case Array do

  method :splice do

    test do
      a = [1,2,3]
      a.splice(1).assert == 2
      a.assert == [1,3]
    end

    test do
      a = [1,2,3]
      a.splice(1,4).assert == 4
      a.assert == [1,4,3]
    end

  end

end
