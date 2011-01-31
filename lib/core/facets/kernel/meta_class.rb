module Kernel

  # Easy access to an object's "special" class, otherwise known as it's
  # singleton class, eigenclass, adhoc class or object-qua-class.
  # 
  def meta_class(&block)
    if block_given?
      (class << self; self; end).class_eval(&block)
    else
      (class << self; self; end)
    end
  end

  # The non-underscored form of #meta_class if faily common.
  alias_method :metaclass, :meta_class

end
