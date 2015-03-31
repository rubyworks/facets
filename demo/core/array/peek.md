## Array#peek

    require 'facets/array/peek'
    
Provide an index to inspect the array from back to front.

    [1,2,3].peek    .assert == 3
    [1,2,3].peek(1) .assert == 2
    [1,2,3].peek(-1).assert == 1

