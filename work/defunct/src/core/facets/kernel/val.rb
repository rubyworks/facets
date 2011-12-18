module Kernel

  # Tests to see if something has value. An object
  # is considered to have value if it is not nil?
  # and if it responds to #empty?, is not empty.
  #
  #   nil.val?     #=> false
  #   [].val?      #=> false
  #   10.val?      #=> true
  #   [nil].val?   #=> true

  def val?
    return false if nil?
    return false if empty? if respond_to?(:empty?)
    true
  end

end

