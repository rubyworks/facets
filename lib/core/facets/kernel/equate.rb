module Kernel

  # Broad equality.
  # 
  # Checks to see if the object +x+ is in any
  # way equal to the reciever, starting with the 
  # identity #equals? and ending with #===.
  #
  def equate?(x)
    equal?(x) || eql?(x) || self == x || self === x
  end

end
