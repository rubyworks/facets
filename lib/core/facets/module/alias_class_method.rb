class Module

  # Alias a class method.
  #
  #   class Greeter
  #     def self.hello; "Hello"; end
  #     alias_class_method :hi, :hello
  #   end
  #
  #   Greeter.hi  #=> "Hello"
  #
  def alias_class_method(name, target)
    singleton_class.alias_method(name, target)
  end

end
