class Regexp

  # Operator form of `Regexp.union`:
  #
  #   /a/ | /b/  #=> /(a|b)/
  #
  def |(arg)
    Regexp.union(self, arg.is_a?(Regexp) ? arg : arg.to_s)
  end

end
