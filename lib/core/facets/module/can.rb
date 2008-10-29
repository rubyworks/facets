class Module

  # An alias for #extend.
  #
  #   class X
  #     can Forwardable
  #   end
  #
  # BTW, why is Forwardable an -able? It's not a mixin!

  alias_method :can, :extend

end

