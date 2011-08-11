covers 'facets/array/pull'

test_case Array do

  method :pull do

    test do
      a = [1,2,3]
      a.pull.assert == 1
      a.assert == [2,3]
    end

  end

end
