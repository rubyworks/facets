require 'facets/math/approx_equal'

module Math

  # Calculates the Gini Coefficient (a measure of inequality of a distribution
  # based on the area between the Lorenz curve and the uniform curve).
  #
  # http://en.wikipedia.org/wiki/Gini_coefficient
  #
  # This is a slightly cleaner way of calculating the Gini Coefficient then
  # the previous implementationj.
  #
  #   GC = \frac{\sum_{i=1}^N (2i-N-1)x_i}{N^2-\bar{x}}
  #
  def self.gini_coefficient(array)
    return -1 if size <= 0 or any? { |x| x < 0 }
    return 0 if size < 2 or all? { |x| approx_equal(x,0) }
    s = 0
    sort.each_with_index { |li,i| s += (2*i+1-size)*li }
    s.to_f/(size**2*mean).to_f
  end

  ## OLD WAY
  ##   GC = \frac{1}{N} \left ( N+1-2\frac{\sum_{i=1}^N (N+1-i)y_i}{\sum_{i=1}^N y_i} \right )
  ## def self.gini_coefficient2(array)
  ##   return -1 if size <= 0 or any? { |x| x < 0 }
  ##   return 0 if size < 2 or all? { |x| Math::float_equal(x,0) }
  ##   s = 0
  ##   sort.each_with_index { |yi,i| s += (size - i)*yi }
  ##   (size+1-2*(s.to_f/sum.to_f)).to_f/size.to_f
  ## end

end
