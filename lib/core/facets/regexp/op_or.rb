class Regexp

  # Add regular expressions.
  #
  #   /a/ | /b/ == /(?-mix:a)(?-mix:b)/
  #
  # Functionally equivalent to:
  #
  #   /ab/
  #
  # CREDIT:
  def |(other)
    other = Regexp.escape(other) if other.is_a?(String)
    /#{self}|#{other}/
  end

end

