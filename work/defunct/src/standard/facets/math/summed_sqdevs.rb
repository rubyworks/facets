require 'facets/math/sum'
require 'facets/math/mean'

module Math

  # The sum of the squared deviations from the mean.
  #
  def self.summed_sqdevs(array)
    return 0 if array.size < 2
    m = mean(array)
    sum(array.map{ |x| (x - m) ** 2 })
  end

end
