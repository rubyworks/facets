module Kernel

  # Easy access to an object's "special" class.

  def singleton_class(&block)
    (class << self; self; end)
  end unless method_defined?(:singleton_class)

end
