## Array#unique_permutation

    require 'facets/array/unique_permutation'
    
Enumerates permutation of Array.  Unlike Array#permutation, there are no 
duplicates in generated permutations.  Instead elements must be comparable

      p = [1,1,2,2,3].unique_permutation(2).to_a
      e = [[1, 1], [1, 2], [1, 3], [2, 1], [2, 2], [2, 3], [3, 1], [3, 2]]
      p.assert == e

      [1,1,2,3].unique_permutation.to_a.assert != [1,1,2,3].permutation.to_a

      [1,1,2,3].unique_permutation.to_a.assert == [1,1,2,3].permutation.to_a.uniq
