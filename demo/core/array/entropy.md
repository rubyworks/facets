## Array#entropy

    require 'facets/array/entropy'

Shannon's entropy for an array - returns the average
bits per symbol required to encode the array.
Lower values mean less "entropy" - i.e. less unique
information in the array.

    e = %w{ a b c d e e e }.entropy

    ("%.3f" % e)  #=> "2.128"

