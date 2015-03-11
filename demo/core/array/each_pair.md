## Array#each_pair

    require 'facets/array/each_pair'

Iterate over an array yielding with index and value.

    result = {}
    a = [:a,:b,:c,:d]
    a.each_pair{|i,e| result[e] = i + 1}
    result.assert == {a: 1, b: 2, c: 3, d: 4}

*NOTE* this is the inverse of `Array#each_with_index`, and is intended to provide
polymorphism with `Hash#each_pair`.
