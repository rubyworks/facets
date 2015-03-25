## Array#missing

    require 'facets/array/missing'

Determine the 'holes' in the values of an array.  Returns the missing elements
in an array set.

    [1,3..3].missing.assert == [2]
    [1..5,10..12].missing.assert == [6..9]
    [100, 9..11, 14, 1..5, 16, 10..12, 17..17].missing.assert == [6..8, 13, 15, 18..99]
