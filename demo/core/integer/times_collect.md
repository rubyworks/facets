## Integer#times_collect

    require 'facets/integer/of'

    a = 4
    b = a.times_collect{ |i| i*2 }
    b.assert == [0,2,4,6]

See `Integer#of` which is an alias.
