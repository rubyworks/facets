class Module

  private

  # Alias a module function so that the alias is also
  # a module function. The typical #alias_method
  # does not do this.
  #
  #   module AliasExample
  #     module_function
  #     def hello
  #       "Hello"
  #     end
  #   end
  #
  #   AliasExample.hello  #=> 'Hello'
  #
  #   module AliasExample
  #     alias_module_function( :hi , :hello )
  #   end
  #
  #   AliasExample.hi     #=> 'Hello'
  #
  def alias_module_function(new, old)
    alias_method(new, old)
    return module_function(new) unless singleton_class.method_defined?(old)
    # Alias the singleton method directly. On JRuby, a singleton method made
    # by #module_function turns private when it is itself aliased later.
    singleton_class.send(:alias_method, new, old)
  end

end

