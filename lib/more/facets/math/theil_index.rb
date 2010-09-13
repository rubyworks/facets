require 'facets/math/sum'
require 'facets/math/mean'
require 'facets/math/approx_equal'

module Math

  # Calculates the Theil index (a statistic used to measure
  # economic inequality).
  #
  # TI = \sum_{i=1}^N \frac{x_i}{\sum_{j=1}^N x_j} ln \frac{x_i}{\bar{x}}
  #
  #   http://en.wikipedia.org/wiki/Theil_index
  #
  def self.theil_index(array)
    return -1 if array.size <= 0 or any? { |x| x < 0 }
    return  0 if array.size <  2 or all? { |x| approx_equal(x, 0) }
    m = mean(array)
    s = sum(array).to_f
    inject(0) do |theil, xi|
	    theil + ((xi > 0) ? (log(xi.to_f/m) * xi.to_f/s) : 0.0)
    end
  end

end
