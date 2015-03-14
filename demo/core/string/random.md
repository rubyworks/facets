## String#random

    require 'facets/string/random'

Generates a random string of given length, using given character set

    s = String.random
    # "D9DxFIaqR3dr8Ct1AfmFxHxqGsmA4Oz3"
    s.assert =~ /^[0-9a-zA-Z]{32}$/

    s = String.random(10)
    # "t8BIna341S"
    s.assert =~ /^[0-9a-zA-Z]{10}$/

    s = String.random(10, ['a'..'z'])
    # "nstpvixfri"
    s.assert =~ /^[a-z]{10}$/

    s = String.random(10, ['0'..'9'] )
    # "0982541042"
    s.assert =~ /^[0-9]{10}$/

    s = String.random(10, ['0'..'9','A'..'F'] )
    # "3EBF48AD3D"
    s.assert =~ /^[0-9A-F]{10}$/
