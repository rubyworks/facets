## Array#recursively

    require 'facets/array/recursively'

Apply a method to  array, and recursively apply that method to each sub-array
or given +types+.

By default the sub-types are passed through unaffected. Passing a block
to #recursively can be used to change this.

each

    r = []
    [1,2,['a','b'], 3].recursively.each{|v| r << v}
    r.assert = [1,2,'a','b', 3]
    
map

    arr = ['foo','bar',['a','b']]
    arr.recursively.map{|v| v.to_sym}.assert == [:foo,:bar,[:a,:b]]
