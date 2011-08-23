module Comparable

  # Returns the lower of self or x.
  #
  #   4.at_least(5)  #=> 5
  #   6.at_least(5)  #=> 6
  #
  # CREDIT: Florian Gross

  def at_least(lower)
    (self >= lower) ? self : lower
  end

  # Returns the greater of self or x.
  #
  #   4.at_most(5)  #=> 4
  #   6.at_most(5)  #=> 5
  #
  # CREDIT: Florian Gross

  def at_most(upper)
    (self <= upper) ? self : upper
  end

  # Returns the greater of self or x.
  #
  #   4.cap(5)  #=> 4
  #   6.cap(5)  #=> 5
  #
  # CREDIT: Trans

  alias_method :cap, :at_most

end
