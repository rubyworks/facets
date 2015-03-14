## Comparable#at_least

    require 'facets/comparable/at_least'

Limits a number to at least a given amount.

    3.at_least(4).assert == 4
    4.at_least(4).assert == 4
    5.at_least(4).assert == 5

This is similar to `#clip`.
