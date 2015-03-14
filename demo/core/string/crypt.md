## String#crypt

    require 'facets/string/crypt'

Adds a default salt to the built-in crypt method.

NOTE: This method is not a common core extension and is not
loaded automatically when using <code>require 'facets'</code>.

     "abc".crypt('ZZ').assert.start_with?('ZZ')

     encrypted = "abc".crypt
     salt = encrypted[0..1]
     "abc".crypt(salt).assert == encrypted

