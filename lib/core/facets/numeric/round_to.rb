class Numeric

  # Conceptually, rounding is expected to apply to floating point numbers.
  # However it can actually be applied to pretty much any Numeric object.
  # For example, one could round an Integer to the nearest kilo.
  #
  # See Float#round_to.

  def round_to(*args)
    to_f.round_to(*args)
  end

end

class Float

  # Rounds to the nearest _n_th degree.
  #
  #   4.555.round_to(1)     #=> 5.0
  #   4.555.round_to(0.1)   #=> 4.6
  #   4.555.round_to(0.01)  #=> 4.56
  #   4.555.round_to(0)     #=> 4.555
  #
  # CREDIT: Trans

  def round_to( n ) #n=1
    return self if n == 0
    (self * (1.0 / n)).round.to_f / (1.0 / n)
  end

end

