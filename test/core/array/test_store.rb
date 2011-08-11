covers 'facets/array/store'

test_case Array do

  method :store do

    test do
      a = [1,2,3,4,5]
      a.store(0, :A)
      a.assert == [:A,2,3,4,5]
    end

    test do
      a = [1,2,3,4,5]
      a.store(-1, :Z)
      a.assert == [1,2,3,4,:Z]
    end

  end

end

