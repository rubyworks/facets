## String#squish

    require 'facets/string/squish'

Returns the string, first removing all whitespace on both ends of the string,
and then changing remaining consecutive whitespace groups into one space each.

    r = %{ Multi-line
           string }.squish
    r.assert == "Multi-line string"

    r = " foo   bar    \n   \t   boo".squish
    r.assert == "foo bar boo"

## String#squish!

Performs a destructive squish. See String#squish.

    r = %{ Multi-line
           string }
    r.squish!
    r.assert == "Multi-line string"

    r = " foo   bar    \n   \t   boo"
    r.squish!
    r.assert == "foo bar boo"

