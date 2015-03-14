## Integer#multiple?

    require 'facets/integer/multiple'

Is a number an even multiple of another?

    1.multiple?(2)  #=> false
    5.multiple?(3)  #=> false

    2.multiple?(2)  #=> true
    6.multiple?(3)  #=> true

