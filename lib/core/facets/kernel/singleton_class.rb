module Kernel

  # Easy access to an object's "special" class.
  #
  # NOTE: This is already defined in Ruby 1.9+.
  def singleton_class
    (class << self; self; end)
  end unless method_defined?(:singleton_class)

end
