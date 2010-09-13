module Math

  # Beta function of +x+ and +y+ - <code>beta(+x+, +y+) =
  # tgamma(+x+) * tgamma(+y+) / tgamma(+x+ + +y+)</code>
  def self.beta(x, y)
    exp(lgamma(x) + lgamma(y) - lgamma(x+y))
  end

end
