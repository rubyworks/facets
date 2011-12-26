require 'facets/math/lgamma'

module Math

  # Exp of LGamma.
  def self.tgamma(x)
    exp(lgamma(x))
  end

end
