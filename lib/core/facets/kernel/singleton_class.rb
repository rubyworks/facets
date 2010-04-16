module Kernel

  # Easy access to an object's "special" class.
  #
  # <b>This is part of Ruby as of 1.9.2+.</b>
  #
  # NOTE: This used to support a class eval block,
  # but to comply with Ruby 1.9.2's definition
  # it has been removed.

  def singleton_class(&block)
    #if block_given?
    #  (class << self; self; end).class_eval(&block)
    #else
      (class << self; self; end)
    #end
  end unless method_defined? :singleton_class

end

