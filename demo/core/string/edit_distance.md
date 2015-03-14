## String#edit_distance

    require 'facets/string/edit_distance'

Levenshtein distance algorithm implementation for Ruby, with UTF-8 support.

The Levenshtein distance is a measure of how similar two strings s and t are,
calculated as the number of deletions/insertions/substitutions needed to
transform s into t. The greater the distance, the more the strings differ.

    d = "pretzel".edit_distance('pretzil')
    d.assert = 1

    d = "zretzel".edit_distance('pretzil')
    d.assert = 2
