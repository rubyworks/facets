covers 'facets/array/unique_permutation'

test_case Array do

  method :unique_permutation do

    test 'example' do
      [1,1,2,2,3].unique_permutation(2).to_a.assert == [
        [1, 1], [1, 2], [1, 3], [2, 1], [2, 2], [2, 3], [3, 1], [3, 2]
	  ]
    end

    test 'not eq permutation.to_a' do
      [1,1,2,3].unique_permutation.to_a.assert != [1,1,2,3].permutation.to_a
    end

    test 'eq permutation.to_a.uniq' do
      [1,1,2,3].unique_permutation.to_a.assert == [1,1,2,3].permutation.to_a.uniq
    end

  end

end
