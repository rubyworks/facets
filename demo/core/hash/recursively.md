## Hash#recursively

    require 'facets/hash/recursively'

    h = {:a=>1, :b=>{:c=>3}}

Without a block passed to the `#recursively` method, the block passed to the
enumeratig method will be used for both recursive and non-recursive yields.

    r = h.recursively.map{ |k,v| [k.to_s, v] }

    r.assert == [['a', 1], ['b', [['c', 3]]]]

But if we pass a block to `#recursively` we can treat the recusive yield 
separately, which in turn allows us to manipulate the non-recursive
yields with a different procedure.

    r = h.recursively{ |k,v| [k.to_s, v] }.map{ |k,v| [k.to_s,v.to_s] }

    r.assert == [['a','1'], ['b', [['c', '3']]]]

