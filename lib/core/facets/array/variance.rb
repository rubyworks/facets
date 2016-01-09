require 'facets/array/average'

class Array

  # Calculate the variance of an array of numbers
  #
  # Examples
  #
  #   [].variance #=> nil
  #   [1, 2, 3].variance #=> 0.6666666666666666
  #   [96, 35, 72, 30, 75, 33, 68, 13, 49, 71].variance #=> 609.76
  #   [36, -67, -17, 85, -46, -64, -23, -13, 89, -47].variance #=> 2989.0099999999993
  #   [60.7829, 31.2622, 20.626, 78.8907, 61.5328].variance #=> 459.1941339495999
  #
  def variance
    avg = average
    map {|n| (n - avg) ** 2 }.average
  end
end

