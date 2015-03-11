## Array#contains?

_alias of Array#include? _

    require 'facets/array/contains'

    [1,2,3,4].assert.contains?(2)
    [1,2,3,4].refute.contains?(9)

