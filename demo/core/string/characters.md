## String#characters

The String#chars methods simply splits a string into
an Array of character strings.

    require 'facets/string/characters'

    "abc".characters.assert == ["a","b","c"]

    "ab\nc".characters.assert == ["a","b","\n","c"]

