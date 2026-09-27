module Kernel

  # @deprecated Use public_send instead (built-in since Ruby 1.9.2).
  #   Scheduled for removal after 2027-09-30.
  def object_send(name, *args, &blk)
    warn "Kernel#object_send is deprecated. Use public_send instead. It will be removed after 2027-09-30.", uplevel: 1
    public_send(name, *args, &blk)
  end

end
