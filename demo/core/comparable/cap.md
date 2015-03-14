## Comparable#cap

    require 'facets/comparable/cap'

Put a cap on what a number can be.

    3.cap(4).assert == 3
    4.cap(4).assert == 4
    5.cap(4).assert == 4

This is very similar to `#at_most`.
