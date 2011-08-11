covers 'facets/array/contains'

test_case Array do

  method :contains? do

    test do
      [1,2,3,4].assert.contains?(2)
      [1,2,3,4].refute.contains?(9)
    end

  end

end
