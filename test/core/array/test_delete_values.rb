covers 'facets/array/delete_values'

test_case Array do

  method :delete_values do

    test do
      a = [1,2,3,4]
      a.delete_values(1,2).assert == [1,2]
      a.assert                    == [3,4]
    end

  end

  method :delete_values_at do

    test do
      a = [1,2,3,4]
      a.delete_values_at(1,2).assert == [2,3]
      a.assert                       == [1,4]
    end

    test do
      a = [1,2,3,4]
      a.delete_values_at(0..2).assert == [1,2,3]
      a.assert                        == [4]
    end

  end

end
