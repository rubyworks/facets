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
    module_function(new)
  end

end

