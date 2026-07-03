## Enumerable#squeeze

    require 'facets/enumerable/squeeze'

Returns a new array with consecutive duplicate entries collapsed. Unlike
`Array#uniq`, duplicate values are only removed when they are adjacent.

    [1, 2, 2, 3, 3, 2, 1].squeeze.assert == [1, 2, 3, 2, 1]

When the enumerable is sorted first, adjacent duplicates become grouped, so
the result matches `uniq`.

    [1, 2, 2, 3, 3, 2, 1].sort.squeeze.assert == [1, 2, 3]

Pass one or more values to squeeze only those values.

    [1, 2, 2, 3, 3, 2, 1].squeeze(3).assert == [1, 2, 2, 3, 2, 1]
