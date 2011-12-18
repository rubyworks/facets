class Regexp

  # Operator form of `Regexp.union`:
  #
  #   /a/ | /b/  #=> /(a|b)/
  #
  # NOTE: This is not (presently) a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  def |(arg)
    Regexp.union(self, arg.is_a?(Regexp) ? arg : arg.to_s)
  end

end
