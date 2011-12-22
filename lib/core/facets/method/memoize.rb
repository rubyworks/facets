class Method

  # Memoize a method by defining a singleton override.
  #
  # NOTE: This method is not a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  #
  # @uncommon
  #   require 'facets/method/memoize'
  #
  def memoize(value)
    singleton = (class << receiver; self; end)
    singleton.__send__(:define_method, name){ value }
  end

end

