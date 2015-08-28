## Array#occur

    require 'facets/array/occur'
    
Returns a list of elements that occur +n+ times.

If +n+ is a Range then returns elements that occur a number 
of time within the range.

    a = [:a,:b,:a]
    a.occur(1).assert == [:b]
    a.occur(2).assert == [:a]

    a = [:a,:b,:a]
    a.occur(1..2).assert == [:a,:b]

    a = [:a,:b,:a]
    a.occur{ |n| n % 2 == 0 }.assert == [:a]
