## String#acronym

    require 'facets/string/acronym'

Transform a string into an acronym.

    'abc'.acronym.assert == 'a'
    'abc def'.acronym.assert == 'ad'
    'abc def ghi'.acronym.assert == 'adg'
