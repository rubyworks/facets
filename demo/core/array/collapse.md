## Array#collapse

    require 'facets/array/collapse'

Simplify an array by flattening it then compacting it.

    [1,[2,nil,[3]],nil,4].collapse.assert == [1,2,3,4]

## Array#collapse!

Simplify an array by flattening it in place then compacting it in place.

    a = [1, nil, [1, 2], nil, [[3]]]
    a.collapse!
    a.assert == [1, 1, 2, 3]
