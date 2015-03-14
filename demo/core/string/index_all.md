## String#index_all

    require 'facets/string/index_all'

Returns an array of all index locations.  the reuse flag allows the trailing
portion of a match to be resued for subsequent matches.

    "abcabcabc".index_all('a')  #=> [0,3,6]

    "a123a567a9".index_all(/a/)  #=> [0,4,8]

    "bbb".index_all('bb', false)  #=> [0]
    "bbb".index_all('bb', true)   #=> [0,1]

