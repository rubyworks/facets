module Kernel

  # @deprecated Use singleton_class or meta_class instead.
  def instance_class(&block)
    warn "Kernel#instance_class is deprecated. Use singleton_class or meta_class instead.", uplevel: 1
    singleton_class.module_eval(&block) if block
    singleton_class
  end

end
