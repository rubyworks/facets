## Array#splice

    require 'facets/array/splice'
    
Splice acts as a combination of #slice! and #store.  If one argument is given it
calls #slice!, if two are given it calls #store.

    a = [1,2,3]
    a.splice(1).assert == 2
    a.assert == [1,3]
    
    b = [1,2,3]
    b.splice(1,4).assert == 4
    b.assert == [1,4,3]
