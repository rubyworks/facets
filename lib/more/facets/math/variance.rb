require 'facets/math/summed_sqdevs'

module Math

  #
  def self.variance(array, &block)
    sum2 = if block_given?
      sum(array){ |i| j = block[i]; j*j }
    else
      sum(array){ |i| i**2 }
    end
    sum2/array.size - mean(array, &block)**2
  end

  # Variance of the sample.
  # Variance of 0 or 1 elements is 0.0.
  #
  # TODO: Same as #variance? Then choose one.
  def self.variance2(array)
    return 0.0 if array.size < 2
    summed_sqdevs(array) / (array.size - 1)
  end

  # Variance of a population.
  # Variance of 0 or 1 elements is 0.0.
  def self.pvariance(array)
    return 0.0 if array.size < 2
    summed_sqdevs(array) / array.size
  end

end
