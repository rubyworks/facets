## String#snakecase

    require 'facets/string/snakecase'

Underscore a string such that camelcase, dashes and spaces are
replaced by underscores. This is the reverse of {#camelcase},
albeit not an exact inverse.

    'my_name'.snakecase.assert == 'my_name'

    'MyName'.snakecase.assert == 'my_name'

    'URI'.snakecase.assert == 'uri'

