module Kernel

  # Is self included in other?
  #
  #   5.in?(0..10)       #=> true
  #   5.in?([0,1,2,3])   #=> false
  #
  def in?(other)
    other.include?(self)
  end

end

