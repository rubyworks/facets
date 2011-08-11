covers 'facets/array/mode'

test_case Array do

  method :mode do

    test do
      [1, 1, 2, 3].mode.assert == [1]
    end

    test do
      [1, 1, 2, 2, 3].mode.sort.assert == [1,2]
    end

  end

end
