covers 'facets/enumerable/every'

test_case Enumerable do

  method :every do

    test do
      a = [1,2,3]
      (a.every + 3 ).assert == [4,5,6]
      (a.every - 1).assert == [0,1,2]
      (a.every.to_s).assert == ['1','2','3']
    end

    test "on Enumerator" do
      e = [1,2,3].to_enum(:map)
      r = e.every + 3
      r.assert == [4,5,6]
    end

  end

  method :every! do

    test do
      a = [1,2,3]
      a.every! + 3
      a.assert == [4,5,6]
    end

  end

end

