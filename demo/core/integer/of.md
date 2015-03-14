## Integer#of

    require 'facets/integer/of'

Similar to `Enumerable#map` and `Enumerable#collect` but for a number
of times.

    a = 4
    b = a.of{ |i| i*2 }
    b.assert == [0,2,4,6]

