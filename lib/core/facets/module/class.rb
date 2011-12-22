class Module

  # Alias for #===. This provides a verbal method
  # for inquery.
  #
  #   s = "HELLO"
  #   String.class?(s)  #=> true
  #
  alias_method :class?, :===

end

