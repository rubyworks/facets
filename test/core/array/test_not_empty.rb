covers 'facets/array/not_empty'

test_case Array do

  method :not_empty? do

    test do
      [].refute.not_empty?
    end

    test do
      [1,2].assert.not_empty?
    end

  end

end
