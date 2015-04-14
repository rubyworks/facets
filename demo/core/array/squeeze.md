## Array#squeeze!

    require 'facets/array/squeeze'
    
Destructive version of Enumerable#squeeze.

    a = [1,2,2,3,3,2,1]
    a.squeeze!
    a.assert == [1,2,3,2,1]
    
    a = [1,2,2,3,3,2,1]
    a.squeeze!(3)
    a.assert == [1,2,2,3,2,1]
    
