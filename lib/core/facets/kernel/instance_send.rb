module Kernel

  # @deprecated Use __send__ instead.
  def instance_send(name, *args, &blk)
    warn "Kernel#instance_send is deprecated. Use __send__ instead.", uplevel: 1
    __send__(name, *args, &blk)
  end

end
