## Array#after

    require 'facets/array/after'

`Array#after` returns the first value that comes after a given value. The
value after the last is the first. Returns `nil` if the given value is not
in the array.

    sequence = ['a', 'b', 'c']
    sequence.after('a').assert == 'b'
    sequence.after('b').assert == 'c'
    sequence.after('c').assert == 'a'
    sequence.after('d').assert == nil
