## Array#pull

    require 'facets/array/pull'
    
Alias for Array#shift which removes an object off the first slot of an array.
This is the opposite of pop.

    a = [1,2,3]
    a.pull.assert == 1
    a.assert == [2,3]
