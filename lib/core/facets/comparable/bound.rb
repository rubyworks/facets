module Comparable

  # Alias for Comparable#clamp. Reads more naturally in some contexts.
  #
  #   4.bound(2, 7)  #=> 4
  #   9.bound(2, 7)  #=> 7
  #   1.bound(2, 7)  #=> 2
  #
  def bound(lower, upper=nil)
    upper ? clamp(lower, upper) : clamp(lower..)
  end

end
