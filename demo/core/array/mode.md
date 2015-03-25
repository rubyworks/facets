## Array#mode

    require 'facets/array/mode'
    
In Statistics, mode is the value that occurs most frequently in a given set of
data. This method returns an array in case there is a tie.

    [1, 1, 2, 3].mode.assert    == [1]
    [1, 1, 2, 2, 3].mode.assert == [1,2]
