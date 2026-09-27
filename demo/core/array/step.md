## Array#step

    require 'facets/array/step'
    
Iterate over every nth element of an array.  Without a block, it returns an 
Enumerator.

    r = []
    [:a, :b, :c, :d].step(2) { |x| r << x }
    r.assert == [:a, :c]
    
    [:a, :b, :c, :d].step(1).to_a.assert == [:a, :b, :c, :d]
    [:a, :b, :c, :d].step(2).to_a.assert == [:a, :c]
    [:a, :b, :c, :d].step(3).to_a.assert == [:a, :d]
    [:a, :b, :c, :d].step(4).to_a.assert == [:a]
    [:a, :b, :c, :d].step(5).to_a.assert == [:a]
