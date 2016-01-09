require 'facets/array/variance'

class Array

  # Calculate the standard_deviation of an array of numbers
  #
  # Examples
  #
  #   [].standard_deviation #=> nil
  #   [1, 2, 3].standard_deviation #=> 0.816496580927726
  #   [96, 35, 72, 30, 75, 33, 68, 13, 49, 71].standard_deviation #=> 24.69331893448104
  #   [36, -67, -17, 85, -46, -64, -23, -13, 89, -47].standard_deviation #=> 54.67183918618432
  #   [60.7829, 31.2622, 20.626, 78.8907, 61.5328].standard_deviation #=> 21.428815505053002
  #
  def standard_deviation
    return nil if empty?
    Math.sqrt(variance)
  end

  alias sd standard_deviation
end


