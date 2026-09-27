## String#similarity

    require 'facets/string/similarity'

A fuzzy matching mechanism. Returns a score from 0-1, based on the number of
shared edges. To be effective, the strings must be of length 2 or greater.

    "Alexsander".similarity("Aleksander").assert == 0.9

    "Alexander".similarity("Alexander").assert == 1.0

    "Alexander".similarity("").assert == 0.0
