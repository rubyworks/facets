module Kernel

  # Easy access to an object qua class, otherwise
  # known as the object's singleton class.
  #
  # Yes, another one.
  #
  #  CREDIT: Trans
  #
  def qua_class(&block)
    if block_given?
      (class << self; self; end).class_eval(&block)
    else
      (class << self; self; end)
    end
  end

end

