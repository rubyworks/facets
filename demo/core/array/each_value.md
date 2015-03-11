## Array#each_value

    require 'facets/array/each_value'

This is an alias of Alias#each, and is provided to provide polymorphism with
Hash#each_value.

    a = [ "a", "b", "c" ]
    out = ''
    a.each_value {|x| out +=  "#{x} -- " }
    out.assert == 'a -- b -- c -- '

