## String#lowercase

    require 'facets/string/lowercase'

Downcase the first letter.

    s = 'Abc'
    s.lowercase.assert == 'abc'

    s = 'ABC'
    s.lowercase.assert == 'aBC'

