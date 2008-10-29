module Kernel

  # Shadow method for instance_variable_get.
  alias_method :__get__, :instance_variable_get

  # Shadow method for instance_variable_set.
  alias_method :__set__, :instance_variable_set

end

