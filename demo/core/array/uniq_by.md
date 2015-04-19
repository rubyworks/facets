## Array#uniq_by!

    require 'facets/array/uniq_by'

Like #uniq, but determines uniqueness based on a given block.  
As can be seen from the examples, order is significant.

    r = (-5..5).to_a
    r.uniq_by!{ |i| i*i }
    r.assert == [-5, -4, -3, -2, -1, 0]
    
    r = (-5..5).to_a.reverse
    r.uniq_by!{ |i| i*i }
    r.assert == [5, 4, 3, 2, 1, 0]
    

