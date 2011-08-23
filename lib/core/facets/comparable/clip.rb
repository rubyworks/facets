module Comparable

  # Returns self if above the given lower bound, or
  # within the given lower and upper bounds,
  # otherwise returns the the bound of which the
  # value falls outside.
  #
  #   4.clip(3)    #=> 4
  #   4.clip(5)    #=> 5
  #   4.clip(2,7)  #=> 4
  #   9.clip(2,7)  #=> 7
  #   1.clip(2,7)  #=> 2
  #
  # CREDIT Florian Gross, Trans

  def clip(lower, upper=nil)
    return lower if self < lower
    return self unless upper
    return upper if self > upper
    return self
  end

  # Returns self if above the given lower bound, or
  # within the given lower and upper bounds,
  # otherwise returns the the bound of which the
  # value falls outside.
  #
  #   4.bound(3)    #=> 4
  #   4.bound(5)    #=> 5
  #   4.bound(2,7)  #=> 4
  #   9.bound(2,7)  #=> 7
  #   1.bound(2,7)  #=> 2
  #
  # CREDIT: Florian Gross

  alias_method :bound, :clip

end
