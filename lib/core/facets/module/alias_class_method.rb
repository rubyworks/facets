class Module

  # Alias a class method.
  #
  def alias_class_method(name, target)
    class << self
      alias_method(name, target)
    end
  end

end
