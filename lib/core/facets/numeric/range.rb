class Numeric

  # Create a range from the number plus-or-minus a given value.
  #
  # Return [Range]
  def range(value)
    Range.new(self - value, self + value)
  end

  alias :plus_or_minus :range

end
