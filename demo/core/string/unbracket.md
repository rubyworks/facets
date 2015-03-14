## String#unbracket

    require 'facets/string/unbracket'

Remove matched paits of brackets from a string

    s = "{unwrap me}"
    z = s.unbracket('{')
    z.assert == "unwrap me"

    s = "--unwrap me!"
    z = s.unbracket('--','!')
    z.assert == "unwrap me"

## String#unbracket!

    s = "{unwrap me}"
    s.unbracket!('{')
    s.assert == "unwrap me"

    s = "--unwrap me!"
    s.unbracket!('--','!')
    s.assert == "unwrap me"

