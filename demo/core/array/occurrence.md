## Array#occurrence

    require 'facets/array/occurrence'

Create a hash of each uniq element of the array
and how many time each appears.

    r = [:a,:a,:b,:c,:c,:c].occurrence
    r.assert == { :a => 2, :b => 1, :c => 3 }

    r = [2,2,3,4,4,4].occurrence{|i| i % 2}
    r.assert == { 0 => 5, 1 => 1 }

