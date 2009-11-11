module Kernel

  # Alias a method defined in the metaclass (ie. singleton class).
  #
  #   def X.y?; "y?" ; end
  #   X.meta_alias "ynot?", "y?"
  #   X.ynot?  #=> y?
  #
  # CREDIT: Trans

  def meta_alias(*args)
    meta_class do
      alias_method(*args)
    end
  end

end

