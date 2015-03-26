## Array#nonuniq

    require 'facets/array/nonuniq'
    
Returns a list of non uniq elements.
  
    a = [1, 1, 2, 2, 3, 4, 5]
    a.nonuniq.sort.assert == [1, 2]

## Array#nonuniq!

Same as #nonuniq but acts in place.

    a = [1, 1, 2, 2, 3, 4, 5]
    a.nonuniq!
    a.sort.assert == [1,2]
