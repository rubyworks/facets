## String#underscore

    require 'facets/string/underscore'

Underscore a string such that camelcase, dashes and spaces are
replaced by underscores. This is the reverse of {#camelcase},
albeit not an exact inverse.

Note, this method no longer converts `::` to `/`, in that case
use the {#pathize} method instead.

    'my_name'.underscore.assert == 'my_name'

    'MyName'.underscore.assert == 'my_name'

    'URI'.underscore.assert == 'uri'

