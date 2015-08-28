covers 'facets/array/op_pow'

test_case Array do

  method :** do

    test do
      ([1,2] ** [3,4]).assert == [[1, 3], [1, 4], [2, 3], [2, 4]]
    end

  end

end
