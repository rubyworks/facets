require 'facets/math/tgamma'

module Math

  # Beta function of `x` and `y`.
  #
  #     beta(x, y) = tgamma(x) * tgamma(y) / tgamma(x + y)
  #
  def self.beta(x, y)
    #exp(lgamma(x).first + lgamma(y).first - lgamma(x+y).first)
    tgamma(x) * tgamma(y) / tgamma(x + y)
  end

end
