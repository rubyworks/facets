## Comparable#bound

    require 'facets/comparable/bound'

The `#bound` method is an alias for `#clip`. It is the original name
of the method before the `clip`/`cap` duo was decided upon.

    3.bound(4).assert == 4

    4.bound(3,5).assert == 4

    'd'.bound('c','e').assert == 'd'

