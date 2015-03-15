## Array#intersection

    require 'facets/array/intersection'
    
Returns the values in common for an array set (nil, single value/object, or range).

    [1,2].intersection.assert == nil
    [1..10,11..20].intersection.assert == nil
    [10,1..10].intersection.assert == 10
    [1..10,5,5..8,4..8].intersection.assert == 5
    [1..10, 5..8, 5..10 ].intersection.assert == (5..8)