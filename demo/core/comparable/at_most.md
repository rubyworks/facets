## Comparable#at_most

    require 'facets/comparable/at_most'

Limits a number to at most a given amount.

    3.at_most(4).assert == 3
    4.at_most(4).assert == 4
    5.at_most(4).assert == 4

This is similar to `#cap`.
