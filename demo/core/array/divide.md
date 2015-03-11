## Array#divide

    require 'facets/array/divide'

Divide into sub arrays at elemetns matching given pattern

    r = ['a1','b1','a2','b2'].divide(/^a/)
    r.assert == [['a1','b1'],['a2','b2']]

    r = ['a1','b1','a2','b2'].divide(/^b/)
    r.assert == [['a1'],['b1','a2'],['b2']]

    r = ['a1','b1','a2','b2'].divide(/c/)
    r.assert = [['a1','b1','a2','b2']]
