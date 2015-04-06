## Array#recurse

    require 'facets/array/recurse'
    
Apply a block to array, and recursively apply that block to each sub-array
or +type+.

    a = ["a", ["b", "c", nil], nil]
    r = a.recurse{|a| a.compact!}
    r.assert == ["a", ["b", "c"]]
