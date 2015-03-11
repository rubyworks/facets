## Array#before

    require 'facets/array/before'

Returns the value prior to the given value. The value previous
to the first is the last. Returns nil if the given value is not
in the array.

    sequence = ['a', 'b', 'c']
    sequence.before('a').assert == 'c'
    sequence.before('b').assert == 'a'
    sequence.before('c').assert == 'b'
    sequence.before('d').assert == nil

