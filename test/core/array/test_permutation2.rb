covers 'facets/array/permutation2'

test_case Array do

  method :permutation2 do

    test 'example' do
      [1,1,2,2,3].permutation2(2).to_a.assert == [
        [1, 1], [1, 2], [1, 3], [2, 1], [2, 2], [2, 3], [3, 1], [3, 2]
	  ]
    end

    test 'not eq permutation.to_a' do
      [1,1,2,3].permutation2.to_a.assert != [1,1,2,3].permutation.to_a
    end

    test 'eq permutation.to_a' do
      [1,1,2,3].permutation2.to_a.assert == [1,1,2,3].permutation.to_a.uniq
    end

  end

end

