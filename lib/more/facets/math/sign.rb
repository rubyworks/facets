module Math

  # Sign of +x+.
  # Returns -1 for negative x, +1 for positive x and zero for x = 0 
  def self.sign(x)
    (x > 0.0) ? 1.0 : ((x < 0.0) ? -1.0 : 0.0)
  end

end
