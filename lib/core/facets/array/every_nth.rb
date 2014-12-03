class Array

  # Returns every nth element in an array
  #
  #   r = [:a, :b, :c, :d].every_nth(1)
  #   r  #=> [:a, :b, :c, :d]
  #   r = [:a, :b, :c, :d].every_nth(2)
  #   r  #=> [:b, :d]
  #   r = [:a, :b, :c, :d].every_nth(3)
  #   r  #=> [:c]
  #   r = [:a, :b, :c, :d].every_nth(5)
  #   r  #=> []
  #
  # Created from code found at: http://stackoverflow.com/a/4689413
  #
  # CREDIT: Ryan Duryea
  def every_nth(n)
    ((n - 1)...self.size).step(n).map { |i| self[i] }
  end
end


