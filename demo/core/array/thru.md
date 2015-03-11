## Array#thru

    require 'facets/array/thru'

Fetch Values from a start index thru an end index.

    [1,2,3,4,5].thru(0,2)  #=> [1,2,3]
    [1,2,3,4,5].thru(2,4)  #=> [3,4,5]

    [1,2,3,4,5].thru(2)  #=> [1,2,3]
    [1,2,3,4,5].thru(4)  #=> [1,2,3,4,5]

