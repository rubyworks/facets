class Array

  # Provides the cartesian product of two or more arrays.
  #
  #   a = [1,2].product([4,5])
  #   a  #=> [[1, 4],[1, 5],[2, 4],[2, 5]]
  #
  # CREDIT: Thomas Hafner
  def self.product(*enums)
    return [] if enums.empty?
    return enums[0].product(*enums[1..-1])
  end

end

