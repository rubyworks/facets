## Array#delete_values_at

    require 'facets/array/delete_values_at'

Delete multiple values from array given
indexes or index range.

    a = [1,2,3,4]
    a.delete_values_at(1,2).assert == [2,3]
    a.assert                       == [1,4]

    a = [1,2,3,4]
    a.delete_values_at(0..2).assert == [1,2,3]
    a.assert                        == [4]

