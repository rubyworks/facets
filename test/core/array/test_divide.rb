covers 'facets/array/divide'

test_case Array do

  method :divide do

    test do
      r = ['a1','b1','a2','b2'].divide(/^a/)
      r.assert == [['a1','b1'],['a2','b2']]
    end

    test do
      r = ['a1','b1','a2','b2'].divide(/^b/)
      r.assert == [['a1'],['b1', 'a2'],['b2']]
    end

    test do
      r = ['a1','b1','a2','b2'].divide(/c/)
      r.assert = [['a1','b1','a2','b2']]
    end

  end

end
