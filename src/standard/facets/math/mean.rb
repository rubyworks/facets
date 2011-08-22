require  'facets/math/sum'

module Math

  # Mean average.
  def self.mean(array, &blk)
    s = array.size
    return 0.0 if s == 0
    sum(array, &blk) / s
  end

  class << self
    alias_method :mean_average, :mean
  end

end
