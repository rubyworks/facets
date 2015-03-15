# Array#median

    require 'facets/array/median'

Determines the _sorted_ middle element.

    a = %w{a a b b c c c}
    a.median     #=> "b"

When there are an even number of elements, the greater
of the two middle elements is given.

    a = %w{a a b b c c c d}
    a.median     #=> "c"

An offset can be supplied to get an element relative
to the middle.

    a = %w{a a b b c c c d}
    a.median(-1) #=> "b"

The the array is empty, +nil+ is returned.

