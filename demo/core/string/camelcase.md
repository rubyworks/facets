## String#Camelcase

    require 'facets/string/camelcase'

The `camelcase` method converts snakecase strings into camelcase strings.

    "abc_xyz".camelcase.assert == "abcXyz"

Continious underscore characters are treated as if a single underscore
character.

    "abc____xyz".camelcase.assert == "abcXyz"

Without an argument the first character is left alone.

    "Camel_case".camelcase.assert == "CamelCase"

Passing +:upper+ or +true+ to #camelcase captializes the first letter.
This is known as upper-camelcase.

    "Abc_xyz".camelcase(true).assert == "AbcXyz"
    "Abc____xyz".camelcase(:upper).assert == "AbcXyz"

Where as passing +false+ or +:lower+ downcases the first character,
known as lower-camelcase.

    "abc_xyz".camelcase(false).assert == "abcXyz"
    "abc____xyz".camelcase(false).assert == "abcXyz"
    "Abc_xyz".camelcase(:lower).assert == "abcXyz"
    "Abc____xyz".camelcase(:lower).assert == "abcXyz"

By passing a match string to the method we can make +camelcase+ 
apply to each word in a string.

    "abc xyz".camelcase(' ').assert  == "abcXyz"
    "abc  xyz".camelcase(/\s/).assert == "abcXyz"
    "abc\txyz".camelcase(/\s/).assert == "abcXyz"
    "abc\nxyz".camelcase(/\s/).assert == "abcXyz"

## String#lower_camelcase

    "abc_xyz".lower_camelcase.assert == "abcXyz"

## String#upper_camelcase

    "abc_xyz".upper_camelcase.assert == "AbcXyz"

