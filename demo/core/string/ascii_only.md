## String#ascii_only

    require 'facets/string/ascii_only'

Return a new string with non-ASCII characters removed.

    'abc'.ascii_only.assert == 'abc'
    '中文123'.ascii_only.assert == '123'

Return a new string with non-ASCII characters replaced.

    '中文123'.ascii_only('!').assert == '!!123'

## String#ascii_only!

Modifiy string with non-ASCII chracters removed.

    s = 'abc'
    s.ascii_only!
    s.assert == 'abc'

    s = '中文123'
    s.ascii_only!
    s.assert == '123'


Modifiy string with non-ASCII chracters replaced.

    s = 'abc'
    s.ascii_only!('!')
    s.assert == 'abc'

    s = '中文123'
    s.ascii_only!('!')
    s.assert == '!!123'


