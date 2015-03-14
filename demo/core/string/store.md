## String#store

    require 'facets/string/store'

Alias for []=

    a = "HELLO"
    a.store(1, "X")
    a.assert == "HXLLO"

