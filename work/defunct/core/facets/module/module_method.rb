class Module

  # Like module_function but makes the instance method
  # public rather than private.
  #
  # NOTE: This does not work as a sectional modifier.

  def module_method(*meth)
    module_function(*meth)
    public(*meth)
  end

end

