module Kernel

  # Returns true is an object is class TrueClass,
  # otherwise false.
  #
  #   true.true?   #=> true
  #   false.true?  #=> false
  #   nil.true?    #=> false
  #
  def true?
    (true == self)
  end

  # Returns true is an object is class FalseClass,
  # otherwise false.
  #
  #   true.false?   #=> false
  #   false.false?  #=> true
  #   nil.false?    #=> false
  #
  def false?
    (false == self)
  end

end

