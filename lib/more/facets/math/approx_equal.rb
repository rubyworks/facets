module Math

  #
  EPSILON = 0.000000001

  # Approximately equal.
  #
  # TODO: Use core extension Numeric#approx? instead.
  def self.approx_equal(a, b, epsilon=EPSILON)
	  c = a - b
	  c *= -1.0 if c < 0
    c < epsilon
  end

end
