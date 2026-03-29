module Kernel

  # @deprecated Use singleton_class or meta_class instead.
  def extension
    warn "Kernel#extension is deprecated. Use singleton_class or meta_class instead.", uplevel: 1
    singleton_class
  end

end
