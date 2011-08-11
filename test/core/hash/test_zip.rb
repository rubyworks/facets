covers 'facets/hash/zip'

test_case Hash do

  class_method :zip do

    test do
      a = [1,2,3]
      b = [4,5,6]
      Hash.zip(a,b).assert == {1=>4,2=>5,3=>6}
    end

  end

end

