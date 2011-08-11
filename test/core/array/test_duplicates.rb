covers 'facets/array/duplicates'

test_case Array do

  method :duplicates do

    test do
      a = [1,1,2,2,3,4,5]
      a.duplicates.assert == [1,2]
    end

  end

end

