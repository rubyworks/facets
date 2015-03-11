## Array#ideal_entropy

    require 'facets/array/entropy'

Returns the maximum possible Shannon entropy of the array
with given size assuming that it is an "order-0" source
(each element is selected independently of the next).

    %w{ a b }.ideal_entropy.assert == 1.0
    %w{ a a b b }.ideal_entropy.assert == 2.0

