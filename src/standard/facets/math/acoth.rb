module Math

  # Area cotangens hyperbolicus of +x+
  def self.acoth(x)
    0.5 * log((x + 1.0) / (x - 1.0))
  end

end
