## Array#thru

    require 'facets/array/from'

Returns elements from index i until the end.

    %w{W o r l d}.from(3).assert == %w{l d}

Returns entire array for i > length

    %w{W o r l d}.from(7).assert == nil
