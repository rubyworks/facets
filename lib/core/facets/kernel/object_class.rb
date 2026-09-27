module Kernel

  # @deprecated Use __class__ instead.
  #   Scheduled for removal after 2027-09-30.
  def object_class
    warn "Kernel#object_class is deprecated. Use __class__ instead. It will be removed after 2027-09-30.", uplevel: 1
    self.class
  end

end
