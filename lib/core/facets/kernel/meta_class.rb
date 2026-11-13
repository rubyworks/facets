module Kernel

  # Easy access to an object's singleton class, with optional block eval.
  #
  #   obj = Object.new
  #   obj.meta_class  #=> obj.singleton_class
  #   obj.meta_class { def foo; end }
  #
  # This is a concise alternative to Ruby's `singleton_class` that also
  # accepts a block for class_eval.
  #
  def meta_class(&block)
    if block_given?
      singleton_class.class_eval(&block)
    else
      singleton_class
    end
  end

  alias_method :metaclass, :meta_class

end
