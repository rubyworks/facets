class Numeric

  # Determines if another number is approximately equal
  # within a given _n_th degree. Defaults to 100ths
  # if the degree is not specified.
  #
  #  CREDIT: Trans

  def approx?(x, n=0.01)
    return(self == x) if n == 0
    (self - x).abs <= n
  end

end

