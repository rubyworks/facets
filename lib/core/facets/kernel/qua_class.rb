module Kernel

  # @deprecated Use singleton_class or meta_class instead.
  #   Scheduled for removal after 2027-09-30.
  def qua_class(&block)
    warn "Kernel#qua_class is deprecated. Use singleton_class or meta_class instead. It will be removed after 2027-09-30.", uplevel: 1
    if block_given?
      singleton_class.class_eval(&block)
    else
      singleton_class
    end
  end

  alias_method :quaclass, :qua_class

end
