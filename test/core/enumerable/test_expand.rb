covers 'facets/enumerable/expand'

test_case Enumerable do

  method :expand do

    test do
      a = [1,2,2,[1,2]]
      r = a.expand
      r == [1,2,2,1,2]
    end

  end

end
