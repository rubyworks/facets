module Kernel

  # @deprecated Use singleton_class or meta_class instead.
  #   Scheduled for removal after 2027-09-30.
  def extension
    warn "Kernel#extension is deprecated. Use singleton_class or meta_class instead. It will be removed after 2027-09-30.", uplevel: 1
    singleton_class
  end

end
