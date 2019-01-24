class Array
  #
  # Swap two elements and return new array
  #
  # @param [Integer] i index of first element to swap
  # @param [Integer] j index of second element to swap
  #
  # @return [Array] new array with elements swapped
  #
  # @example
  #   [1,2,3].swap(1,2) == [1,3,2]
  #
  def swap(i, j)
    self.dup.swap!(i, j)
  end

  #
  # Swap two elements and return modified array
  #
  # @param [Integer] i index of first element to swap
  # @param [Integer] j index of second element to swap
  #
  # @return [Array] original array, modified and elements swapped
  #
  # @example
  #   [1,2,3].swap!(1,2) == [1,3,2]
  #
  def swap!(i, j)
    self[i], self[j] = self[j], self[i]
    self
  end
end
