module Math

  # Logarithmus naturalis of gamma function of `x`.
  # 
  # Notice the use of `ln` prefix to differentiate from
  # Ruby's built-in `#lgamma` function which returns an Array.
  #
  def self.lngamma(x)
    lgamma(x).first
  end

  # Old name used by Extmath library.
  def self.ln_gamma(x)
    lgamma(x).first
  end

end

