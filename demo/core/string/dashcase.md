## String#dashcase

    require 'facets/string/dashcase'

Dashcase a string such that camelcase, underscores and spaces are
replaced by dashes. This is similar to {#underscore},
but with dashes instead of underscores.

    'my_name'.dashcase.assert == 'my-name'

    'MyName'.dashcase.assert == 'my-name'

    'URI'.dashcase.assert == 'uri'
