require 'facets/math/approx_equal'

module Math

  # Calculates the relative mean difference of this sample.
  # Makes use of the fact that the Gini Coefficient is half the RMD.
  def self.rmd(array)
    return 0.0 if approx_equal(mean(array), 0.0)
    gini_coefficient(array) * 2
  end

  class << self
    alias_method  :relative_mean_difference, :rmd
  end

end
