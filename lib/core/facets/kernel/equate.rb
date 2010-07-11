module Kernel

  # Broad equality. Checks to see if the object +x+ is in any
  # way equal to the reciever, starting with the identity
  # #equal?, then #eql?, then #==, and ending with #===.
  #
  #   1.equate?(1.0)               #=> true
  #   "string".equate?("string")   #=> true
  #   String.equate?("string")     #=> true
  #
  def equate?(x)
    equal?(x) || eql?(x) || self == x || self === x
  end

end

