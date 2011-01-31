class Module

  # An alias for #extend.
  #
  #   module EgCan
  #     def foo; "foo"; end
  #   end
  #
  #   class EgCanClass
  #     can EgCan
  #   end
  #
  #   EgCanClass.foo  #=> 'foo'
  #
  # BTW, why is Forwardable an -able? It's not a mixin!

  alias_method :can, :extend

end

