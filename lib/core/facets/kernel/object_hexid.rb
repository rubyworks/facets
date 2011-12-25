module Kernel

  ARCH_SIZE = (['a'].pack('P').length > 4 ? 64 : 32)

  if RUBY_VERSION < '1.9'
    if ARCH_SIZE == 64
      HEXID_TEMPLATE = "0x%012x"
    else
      HEXID_TEMPLATE = "0x%x"
    end
  else
    if ARCH_SIZE == 64
      HEXID_TEMPLATE = "0x%014x"
    else
      HEXID_TEMPLATE = "0x%x"
    end
  end

  # Returns the object id as a string in hexideciaml,
  # which is how Ruby reports them with inspect...
  #
  #   "ABC".object_hexid  #=> "0x402d359c"
  #
  def object_hexid
    HEXID_TEMPLATE % (__id__ << 1)
  end

  # The 1.9.3 definition is as follows:
  #def object_hexid
  #  "0x" + [object_id << 1].pack("L>!").unpack("H*")[0]
  #end

end
