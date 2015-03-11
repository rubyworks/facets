## Array#each_overlap

    require 'facets/array/each_overlap'

Iterate over each slice where the last n values of a preceding slice
overlap with the first n values of the following slice. The value of n
is specified by the second `overlap` argument.

    a, r = [1,2,3,4,5], []
    a.each_overlap(2,1) { |x,y| r << [x,y] }
    r.assert == [[1,2],[2,3],[3,4],[4,5]]

