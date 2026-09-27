module Kernel

  # @deprecated Use __send__ instead.
  #   Scheduled for removal after 2027-09-30.
  def instance_send(name, *args, &blk)
    warn "Kernel#instance_send is deprecated. Use __send__ instead. It will be removed after 2027-09-30.", uplevel: 1
    __send__(name, *args, &blk)
  end

end
