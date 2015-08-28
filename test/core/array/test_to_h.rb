covers 'facets/array/to_h'

test_case Array do

  method :to_h do

    test do
      arr = [[:a, 1], [:b, 2]]
      arr.to_h.assert == {:a => 1, :b => 2}
    end

  end

end
