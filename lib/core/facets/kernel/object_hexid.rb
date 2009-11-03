module Kernel

  if RUBY_VERSION < "1.8.7"

    # Returns the object id as a string in hexideciaml,
    # which is how Ruby reports them with inspect.
    #
    #   "ABC".object_hexid  #=> "0x402d359c"

    def object_hexid
      return "0x" << (('%.x' % (2*self.__id__))[1..-1])
    end

  else

    # Returns the object id as a string in hexideciaml,
    # which is how Ruby reports them with inspect.
    #
    #   "ABC".object_hexid  #=> "0x402d359c"

    def object_hexid
      return "0x" << ('%.x' % (2*self.__id__))  #[1..-1]
    end

  end

end
