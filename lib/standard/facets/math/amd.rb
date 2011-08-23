require 'facets/math/rmd'
require 'facets/math/mean'

module Math
    
  # The average absolute difference of two independent values drawn 
  # from the sample. Equal to the RMD * mean.
  def self.amd(array)
	  rmd(array) * mean(array)
  end

  class << self
    alias_method :absolute_mean_difference, :amd
    #alias_method :md, :mean_difference
  end

end
