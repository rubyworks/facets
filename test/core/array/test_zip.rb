covers 'facets/array/zip'

test_case Array do

  method :zip do

    test 'example' do
      Array.zip([1,2], [3,4]).assert == [[1,3],[2,4]]
    end

  end

end
