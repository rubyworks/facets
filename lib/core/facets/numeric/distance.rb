class Numeric

  # Returns the distance between self an another value.
  # This is the same as #- but it provides an alternative
  # for common naming between variant classes.
  #
  #   4.distance(3)  #=> 1

  def distance(other)
    self - other
  end

end

