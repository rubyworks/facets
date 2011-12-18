module Kernel

  # Returns method of a parent class bound to self.
  def super_method(klass, meth)
    unless self.class.ancestors.include?(klass)
      raise ArgumentError, "Not an ancestor for super_method-- #{klass}"
    end
    klass.instance_method(meth).bind(self)
  end

end
