module Math

  # Returns the Cumulative Density Function of this
  # sample (normalised to a fraction of 1.0).
  def self.cdf(array, normalised=1.0)
    s = sum(array).to_f
    array.sort.inject([0.0]) { |c,d| c << c[-1] + normalised*d.to_f/s }
  end

end
