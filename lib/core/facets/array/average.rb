class Array

  # Calculate the average of an array of numbers
  #
  # Examples
  #
  #   [].average #=> nil
  #   [1, 2, 3].average #=> 2
  #   [3, 12, 57, 85, 15, 89, 33, 7, 22, 54].average #=> 37.7
  #
  def average
    return nil if empty?
    self.reduce(:+)/length.to_f
  end
end
