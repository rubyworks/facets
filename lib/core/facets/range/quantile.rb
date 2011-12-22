class Range

  # Calculate the kth n-tile in a range.
  #
  # If n=4 the quantity is called a quartile, and if n=100
  # it is called a percentile.
  #
  # @uncommon
  #   require 'facets/range/quantile'
  #
  # @return [Integer] the kth n-tile
  def quantile(k, n=100)
    return 1 if k < first
    return n if k >= last
    ((k - first) / ((last - first) / n.to_f)).to_i + 1
  end

end
