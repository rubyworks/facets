class Numeric

  # Determines if another number is approximately equal within a given
  # _n_th degree. Defaults to 100ths if the degree is not specified.
  #
  # Currently defaults to 1/10,000,000 if the degree is not specified.
  # But this may change once a "most commonly useful" factor is determined.
  #
  # This is the same a {#close?} but has a different defualt.
  #
  # @author Gavin Sinclair

  def approx?(x, n=0.0000001)
    close?(x, n)
  end

  # Determines if another number is approximately equal
  # within a given +epsilon+.
  #
  # This is the same a {#approx?} but has a different default.
  # In this case it is 1/100th.
  #
  # @author Gavin Sinclair
  def close?(number, epsilon=0.01)
    return(self == number) if epsilon.zero?

    a, b = self.to_f, number.to_f
    if a.zero? or b.zero?
      ## There's no scale, so we can only go on difference.
      (a - b).abs < epsilon
    else
      ## We go by ratio. The ratio of two equal numbers is one, so the ratio
      ## of two practically-equal floats will be very nearly one.
      (a/b - 1).abs < epsilon
    end
  end

end

