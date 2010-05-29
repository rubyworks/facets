require 'facets/array/percentile'

class Array

  # Returns the median for the array; nil if array is empty
  def median
    percentile(50)
  end

end

