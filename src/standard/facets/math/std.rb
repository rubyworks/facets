require 'facets/math/variance'

module Math

  # Standard deviation of a sample.
  #
  def self.std(array, &block)
    sqrt(variance(array, &block))
  end

  class << self
    alias_method :standard_deviation, :std
  end

  # Standard deviation of a population.
  #
  def self.pstd(array, &block)
    Math::sqrt(pvariance(array, &block))
  end

  # Calculates the standard error of a sample.
  def self.stderr(array)
    return 0.0 if array.size < 2
    std(array) / sqrt(array.size)
  end

end
