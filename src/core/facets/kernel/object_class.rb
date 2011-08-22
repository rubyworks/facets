module Kernel

  # Defines object_classas an alias of class.
  # This is an alternative to __class__, akin to
  # #object_id.

  alias_method :object_class, :class

end

