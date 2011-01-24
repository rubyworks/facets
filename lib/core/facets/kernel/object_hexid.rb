module Kernel

  # Returns the object id as a string in hexideciaml,
  # which is how Ruby reports them with inspect...
  #
  #   "ABC".object_hexid  #=> "0x402d359c"
  #
  def object_hexid
    hex = (__id__ << 1)
    "0x%x" % hex
  end

end
