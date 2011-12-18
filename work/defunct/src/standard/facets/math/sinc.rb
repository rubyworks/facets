module Math

  # Sinc function of +x+.
  def self.sinc(x)
    (x == 0.0) ? 1.0 : sin(x) / x
  end

end
