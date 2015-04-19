## Array#to_h

    require 'facets/array/to_h'

Convert an associative array to a Hash.  Each element of the associative array 
should be a 1 or 2 element array

Note this is built into ruby as of 2.1.0

    arr = [[:a, 1], [:b, 2]]
    arr.to_h.assert == {:a => 1, :b => 2}
