## Array#last!

    require 'facets/array/indexable'
    
Alias for pop, which removes and returns the last element in an
array.

    a = [1,2,3]
    a.last!.assert == 3
    a.assert == [1,2]
    