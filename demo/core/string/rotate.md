## String#rotate

    require 'facets/string/rotate'

Returns a copy of the string rotated left by the given count.

    'abcdefgh'.rotate(2).assert == 'cdefghab'

Negative counts rotate from the right.

    'abcdefgh'.rotate(-2).assert == 'ghabcdef'

## String#rotate!

Performs the rotation in place.

    string = 'abcdefgh'
    string.rotate!(2)
    string.assert == 'cdefghab'

    string = 'abcdefgh'
    string.rotate!(-2)
    string.assert == 'ghabcdef'
