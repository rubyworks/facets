covers 'facets/array/collapse'

test_case Array do

  method :collapse do

    test do
      [1, nil, [1, 2], nil, [[3]]].collapse.assert == [1, 1, 2, 3]
    end

  end

  method :collapse! do

    test do
      a = [1, nil, [1, 2], nil, [[3]]]
      a.collapse!
      a.assert == [1, 1, 2, 3]

    end
  end
end

