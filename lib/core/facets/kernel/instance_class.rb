module Kernel

  # Kernel extension prefixed by instance_ which provide
  # internal (eg private) access to the object.
  # Kernel extension using instance_ prefix which is beneficial
  # to separation of metaprogramming from general programming.
  # object_ methods, in contrast to the instance_ methods,
  # do not access internal state.

  # Easy access to an object qua class, otherwise known
  # as the object's metaclass or singleton class. This
  # implemnetation alwasy returns the class, even if a
  # block is provided to eval against it.
  #
  #     It is what it is.
  #
  #  CREDIT: Trans

  def instance_class(&block)
    (class << self; self; end).module_eval(&block) if block
    (class << self; self; end)
  end

end
