module Kernel

  # Easy access to an object's "special" class,
  #
  # One day these names must be reconciled!

  def singleton_class(&block)
    if block_given?
      (class << self; self; end).class_eval(&block)
    else
      (class << self; self; end)
    end
  end

  # Deprecate?
  alias_method :singleton, :singleton_class

end

