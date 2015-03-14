## String#number?

    require 'facets/string/number'

Returns true if its a decimal number

    x = "1.23\n"
    x.number?.assert == true

    x = "123_456_789_123_456_789.123_456_000_111\n"
    x.number?.assert == true

    x = ".123\n"
    x.number?.assert == false

    x = "123_\n"
    x.number?.assert == false

    x = "_123\n"
    x.number?.assert == false

    x = "23_456_789_123_456_.245\n"
    x.number?.assert == false

    x = "23_456_789_123_456._245\n"
    x.number?.assert == false

