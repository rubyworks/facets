require 'facets/array/percentile'

class Array

  # TODO: Does Array#median belong in a math-oriented library?

  # Returns the median for the array; nil if array is empty.
  #
  # NOTE: This method is not a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  #
  # @non-core
  #   require 'facets/array/median'
  #
  def median
    percentile(50)
  end

end

