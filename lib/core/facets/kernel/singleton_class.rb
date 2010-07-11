module Kernel

  # Easy access to an object's "special" class.
  #
  # NOTE: This used to support a class eval block,
  # but to comply with Ruby 1.9.2's definition
  # it has been removed.

  def singleton_class(&block)
    (class << self; self; end)
  end unless method_defined? :singleton_class

end

