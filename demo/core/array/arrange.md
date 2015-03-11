## Array#arrange

    require 'facets/array/arrange'

The `arrange` method produces appropriate ranges from the objects in the array.
It assumes inclusive ranges (i.e. `1..4`) and `range.first <= range.last`.

Works with integers, dates and strings. However, all the objects in the array must
be of the same class.

    [1,2,3,6,7,8].arrange.assert == [1..3, 6..8]

    [10..15, 16..20, 21, 22].arrange.assert == [10..22]

    a = %w{a b c g h i j k  m o}
    a.arrange.assert == ['a'..'c','g'..'k', 'm' , 'o']

