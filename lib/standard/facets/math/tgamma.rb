require 'facets/math/lgamma'

module Math

  # Exp of LGamma.
  def self.tgamma(x)
    exp(lngamma(x)) #exp(log(gamma(x).abs)
  end

end
