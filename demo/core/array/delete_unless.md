## Array#delete_unless

    require 'facets/array/delete_unless'

The method `#delete_unless` is the inverse of `#delete_if`.

    a = [1,2,3]
    a.delete_unless{ |e| e == 2 }
    a.assert == [2]

    [1,2,3].delete_unless{ |x| x < 2 }.assert == [1]
    [1,2,3].delete_unless(&:even?).assert == [2]

