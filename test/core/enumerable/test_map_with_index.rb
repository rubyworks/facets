covers 'facets/enumerable/map_with_index'

test_case Enumerable do

  method :map_with_index do

    test do
      a = [1,2,3].map_with_index{ |e,i| e*i }
      a.assert == [0,2,6]
    end

  end

  method :collect_with_index do

    test do
      a = [1,2,3].collect_with_index{ |e,i| e*i }
      a.assert == [0,2,6]
    end

  end

end
