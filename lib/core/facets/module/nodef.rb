class Module

  # Alias for undef_method. This has been called "nodef" instead of
  # undef to help clarify that it doesn't get rid of the method, but
  # rather represses repsonse.
  alias_method :nodef, :undef_method

  # Alias for remove_method. This method actually "undefines" a method
  # and will raise an error is the method is not defined in receiver.
  alias_method :remove,  :remove_method

end

