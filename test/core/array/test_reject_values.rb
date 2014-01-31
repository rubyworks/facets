covers 'facets/array/reject_values'

testcase Array do

  method :reject_values do

    test do
      a = [1,2,3,4,5]
      r = a.reject_values(2,4)
      r.assert == [1,3,5]
      a.assert = [1,2,3,4,5]  # hasn't changed
    end

  end

end

