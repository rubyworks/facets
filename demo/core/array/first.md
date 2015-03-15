## Array#first!

    require 'facets/array/indexable'

Alias for shift, which removes and returns the first element in an array
  
    a = ['a','y','z']
    a.first!.assert == 'a'
    a.assert ['y','z']
    
    
