module Kernel

  # Defines core method __class__ as an alias of class.
  # This allows you to use #class as your own method, without
  # loosing the ability to determine the object's class.

  alias_method :__class__, :class

end
