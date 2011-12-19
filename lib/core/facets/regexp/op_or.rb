class Regexp

  # Operator form of `Regexp.union`.
  #
  #   /a/ | /b/  #=> /(?-mix:a)|(?-mix:b)/
  #
  # If +other+ is not a Regexp it is passed to Regexp.escape.
  #
  def |(other)
    other = Regexp.escape(other) unless Regexp === other
    Regexp.union(self, other)
  end

end

