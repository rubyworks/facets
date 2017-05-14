## Array#span

    require 'facets/array/span'

Split an array in two using a block, where the first half is the longest prefix
for which the block evaluates to true, and the second half is the rest of the
array.

    a = [2, 22, 8, 3, 16, 4, 21]
    a.span { true }.assert [[2, 2, 8, 3, 16, 4, 21], []]
    a.span { |e| e < 20 }.assert [[2, 2, 8, 3, 16, 4], [21]]

This method will "stop" at the first element for which the block evaluates to
`false`.

    a.span(&:even?).assert [[2, 2, 8], [3, 16, 4, 21]]
