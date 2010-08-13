class Module

  # Query whether a public instance method is defined for the module.
  #
  # CREDIT: Gavin Sinclair, Noah Gibbs

  def instance_method_defined?(meth)
    instance_methods(true).find{ |m| m == meth.to_s }
  end

  # Query whether a normal (singleton) method is defined for the module.
  #
  # CREDIT: Gavin Sinclair, Noah Gibbs

  def singleton_method_defined?(meth)
    singleton_methods(true).find{ |m| m == meth.to_s }
  end

  #
  alias_method :module_method_defined?, :singleton_method_defined?

end

