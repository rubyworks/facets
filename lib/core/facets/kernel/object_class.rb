module Kernel

  # @deprecated Use __class__ instead.
  def object_class
    warn "Kernel#object_class is deprecated. Use __class__ instead.", uplevel: 1
    self.class
  end

end
