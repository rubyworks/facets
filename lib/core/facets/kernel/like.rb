module Kernel

  # Broad equality. Checks to see if the object +x+ is in any
  # way equal to the reciever, starting with the identity
  # #equal?, then #eql?, then #==, and ending with #===.
  #
  #   1.like?(1.0)               #=> true
  #   "string".like?("string")   #=> true
  #   String.like?("string")     #=> true
  #
  def like?(x)
    equal?(x) || eql?(x) || self == x || self === x
  end

  # @deprecated Use #like? instead.
  #   Scheduled for removal after 2027-09-30.
  def equate?(x)
    warn "Kernel#equate? is deprecated. Use Kernel#like? instead. " \
         "It will be removed after 2027-09-30.", uplevel: 1
    like?(x)
  end

end

