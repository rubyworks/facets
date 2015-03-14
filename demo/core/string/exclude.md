## String#exclude?

    require 'facets/string/exclude'

The inverse of include?.

    "aaaa".assert.exclude?('bb')
    "aaab".assert.exclude?('bb')
    "aaba".assert.exclude?('bb')
    "baaa".assert.exclude?('bb')

    "abba".refute.exclude?('bb')
    "aabb".refute.exclude?('bb')
    "bbaa".refute.exclude?('bb')

