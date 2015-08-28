## Array#poke

    require 'facets/array/poke'
    
Put an object on the bottom of the stack (front of the array).

    a = [2,3]
    a.poke(1)
    a.assert == [1,2,3]
    
Or supply an index and #poke works like insert.

    a = [1,3]
    a.poke(2,1)
    a.assert == [1,2,3]
