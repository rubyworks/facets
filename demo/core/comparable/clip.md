## Comparable#clip

    require 'facets/comparable/clip'

Given a single argument `#clip` behaves like `#at_least`.

    3.clip(4).assert == 4
    4.clip(4).assert == 4
    5.clip(4).assert == 5

With two arguments `#clip` puts both a lower and an upper limit
on the return value.

    4.clip(3,5).assert == 4
    3.clip(3,5).assert == 3
    5.clip(3,5).assert == 5
    2.clip(3,5).assert == 3
    6.clip(3,5).assert == 5

This almost works on characters (using ASCII order).

    'd'.clip('c','e').assert == 'd'
    'c'.clip('c','e').assert == 'c'
    'e'.clip('c','e').assert == 'e'
    'b'.clip('c','e').assert == 'c'
    'f'.clip('c','e').assert == 'e'

This method is aliases as `bound`.

