module Kernel

  if RUBY_VERSION < '1.9'

    # Returns the object id as a string in hexideciaml,
    # which is how Ruby reports them with inspect...
    #
    #   "ABC".object_hexid  #=> "0x402d359c"
    #
    def object_hexid
      hex = (__id__ << 1) #.to_s(16)
      "0x%x" % hex
    end

  else

    # Returns the object id as a string in hexideciaml,
    # which is how Ruby reports them with inspect...
    #
    #   "ABC".object_hexid  #=> "0x402d359c"
    #
    def object_hexid
      hex = (__id__ << 1)
      "0x%014x" % hex
    end

  end

end
