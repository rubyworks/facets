covers 'facets/array/to_ranges'

test_case Array do

  method :to_ranges do

    test do
      [3,4,5,1,6,9,8].to_ranges.assert ==  [1..1,3..6,8..9]
    end

  end
end

