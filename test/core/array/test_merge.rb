covers 'facets/array/merge'

test_case Array do

  method :merge do

    test do
      a = [1,2,3]
      b = [3,4,5]
      a.merge(b).assert == [1,2,3,4,5]
    end

  end

  method :merge! do

    test do
      a = [1,2,3]
      b = [3,4,5]
      a.merge!(b)
      a.assert == [1,2,3,4,5]
    end

  end

end

