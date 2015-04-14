## Array#split

    require 'facets/array/split'
    
Split on matching pattern.  Unlike #divide, this does not include matching 
elements.

    ['a','b','c'].split('b').assert == [['a'],['c']]
    
    a = ['a1','a2','b1','a3','b2','a4']
    a.split(/^b/).assert == [['a1','a2'],['a3'],['a4']]
    
    
