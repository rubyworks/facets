require 'facets/array/percentile'

class Array

  # Returns the median for the array; nil if array is empty
  #--
  # TODO: Does Array#median belong in a math-oriented library?
  #++
  def median
    percentile(50)
  end

end

