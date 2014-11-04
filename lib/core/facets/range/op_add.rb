require 'facets/array/arrange'

class Range

  # Add two ranges to create a range array.
  #
  # Returns [Array]
  #
  # CREDIT: monocle

  def +(value)
		[self, value].arrange
	end

end
