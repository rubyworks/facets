## Array#reject_values

    require 'facets/array/reject_values'
    
Non-destructive form of Array#delete_values. Unlike delete_values this method
returns a new array.

    a = [1,2,3,4,5]
    a.reject_values(2,4).assert == [1,3,5]
    a.assert [1,2,3,4,5]
