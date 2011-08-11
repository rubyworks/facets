covers 'facets/enumerable/sum'

test_case Enumerable do

  method :sum do

    test do
      [1,2,3].sum.assert == 6
    end

  end

end
