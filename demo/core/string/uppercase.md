## String#uppercase

    require 'facets/string/uppercase'

Upcase the first letter.

    s = 'bob'
    s.uppercase.assert == 'Bob'

    s = 'boB'
    s.uppercase.assert == 'BoB'

    s = 'BoB'
    s.uppercase.assert == 'BoB'

