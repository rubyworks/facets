require 'facets/array/percentile'

class Array

  # Returns the median for the array; nil if array is empty.
  #
  # NOTE: This is not (presently) a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  #--
  # TODO: Does Array#median belong in a math-oriented library?
  #++
  def median
    percentile(50)
  end

end

