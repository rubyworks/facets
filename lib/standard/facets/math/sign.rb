module Math

  # Sign of `x`. This function returns `-1.0` if `x` is negative,
  # `+1.0` if `x` is positive `x`, and `0.0` if `x = 0`.
  def self.sign(x, zero=0.0)
    (x > 0.0) ? 1.0 : ((x < 0.0) ? -1.0 : zero)
  end

  # Same as `Math.sign`.
  def self.sgn(x, zero=0.0)
    (x > 0.0) ? 1.0 : ((x < 0.0) ? -1.0 : zero)
  end

  # The *Heaviside step function*, also called the the *unit step function*.
  # This functions works like `Math.sign` but by default returns `1.0` for zero.
  def self.unit_step(x, zero=1.0)
    (x > 0.0) ? 1.0 : ((x < 0.0) ? -1.0 : zero)
  end

end
