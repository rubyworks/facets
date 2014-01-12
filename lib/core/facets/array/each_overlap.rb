class Array

  # Iterate over each slice where the last n values of a preceding slice
  # overlap with the first n values of the following slice. The value of n
  # is specified by the second `overlap` argument.
  #
  #     a, r = [1,2,3,4,5], []
  #     a.each_overlap(2,1) { |x,y| r << [x,y] } 
  #     r # => [[1,2],[2,3],[3,4],[4,5]]
  #
  # Returns nothing.

  def each_overlap(slice_size, overlap)
    if block_given?
		  i = 0
		  while i + slice_size <= length
		    yield slice(i...i+slice_size)
		    i += (slice_size - overlap)
		  end
    else
      to_enum(:each_overlap, slice_size, overlap)
    end
  end

end
