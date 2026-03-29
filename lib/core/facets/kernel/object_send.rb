module Kernel

  # @deprecated Use public_send instead (built-in since Ruby 1.9.2).
  def object_send(name, *args, &blk)
    warn "Kernel#object_send is deprecated. Use public_send instead.", uplevel: 1
    public_send(name, *args, &blk)
  end

end
