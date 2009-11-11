module Kernel

  # Easy access to an object's "special" class,
  # otherwise known as it's metaclass or singleton class.

  def meta_class(&block)
    if block_given?
      (class << self; self; end).class_eval(&block)
    else
      (class << self; self; end)
    end
  end

  alias_method :metaclass, :meta_class

end

