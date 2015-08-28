## Array#traverse

    require 'facets/array/traverse'
    
Construct a new array created by traversing the array and its sub-arrays,
executing the given block on the elements.

    h = ['A', 'B', ['X', 'Y']]
    g = h.traverse{ |e| e.downcase }
    g.assert = ['a','b',['x', 'y']]
    
## Array#traverse!

Like #traverse, but will change the array in place.

    h = ['A', 'B', ['X', 'Y']]
    h.traverse!{ |e| e.downcase }
    h.assert = ['a','b',['x', 'y']]

        
