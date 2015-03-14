## String#remove

    require 'facets/string/remove'

Removes all occurances of a string or pattern from a string.

    s = 'xxbooxxfoo'
    s.remove('xx').assert == 'boofoo'

    s = 'xxbooxxfoo'
    s.remove(/x{1,2}/).assert == 'boofoo'

## String#remove!

    s = 'xxbooxxfoo'
    s.remove!('xx')
    s.assert == 'boofoo'

    s = 'xxbooxxfoo'
    s.remove!(/x{1,2}/)
    s.assert == 'boofoo'


## String#op_minus (-)

    s = 'xxbooxxfoo'
    (s - 'xx').assert == 'boofoo'

    s = 'xxbooxxfoo'
    (s - /x{1,2}/).assert == 'boofoo'



