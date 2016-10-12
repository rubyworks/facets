## Array#split_at

    require 'facets/array/split_at'
    
Split on the first element that matches using Array#index.

    ['a','b','c'].split_at('b').assert == [['a'],'b',['c']]
    
    a = ['a1','a2','b12','a3','b2','a4']
    a.split_at{|e| e.size == 3}.assert == [['a1','a2'],'b12',['a3','b2','a4']]
    
    
